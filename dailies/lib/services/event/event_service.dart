import 'package:dailies_v2/database/daos/event_dao.dart';
import 'package:dailies_v2/enums/event_type.dart';
import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/utils/result.dart';
import 'package:flutter/foundation.dart';

class EventService extends ChangeNotifier {
  final EventDao _dao;

  EventService({EventDao? dao}) : _dao = dao ?? EVENT_DAO;

  Future<Result<void>> deleteAllEventsInSeries(int? eventInfoId) async {
    if (eventInfoId == null || eventInfoId < 0) {
      return Result.error(ValidationFailure('Invalid event id: $eventInfoId'));
    }

    return guardedAsyncExecute(
      () => _dao.deleteAllEventsInSeries(eventInfoId),
      DatabaseFailure('Failed to delete event $eventInfoId'),
    );
  }

  Future<Result<void>> deleteEventInstance(int? instanceId) async {
    if (instanceId == null || instanceId < 0) {
      return Result.error(
        ValidationFailure('Invalid event instance id: $instanceId'),
      );
    }

    return guardedAsyncExecute(
      () => _dao.deleteEventInstance(instanceId),
      DatabaseFailure('Failed to delete event instance id: $instanceId'),
    );
  }

  Future<Result<int>> createEvent(EventInfoModel eventInfo) async {
    final insertInfoResult = await guardedAsyncExecute<int>(
      () => _dao.insertEventInfo(eventInfo.toCompanion()),
      DatabaseFailure('Failed to insert EventInfo ${eventInfo.title}'),
    );

    late final int eventInfoId;

    switch (insertInfoResult) {
      case Ok<int>(value: final id):
        eventInfo.id = id;
        eventInfoId = id;
      case Error<int>(failure: final f):
        return Result.error(f);
    }

    late final List<EventCacheInstanceModel> instances;
    try {
      instances = _generateInstances(eventInfo);
    } catch (e) {
      return Result.error(
        GenerationFailure(
          'Failed to generate instances for ${eventInfo.title}: $e',
        ),
      );
    }

    final insertInstancesResult = await guardedAsyncExecute(
      () => _dao.insertCacheInstances(
        instances.map((e) => e.toCompanion()).toList(),
      ),
      DatabaseFailure('Failed to insert generated instances'),
    );

    if (insertInstancesResult is Error) {
      return Result.error(insertInstancesResult.failure);
    }

    return Result.ok(eventInfoId);
  }

  Stream<List<EventCacheInstanceModel>> watchEventCacheInstances() => _dao
      .watchAllCacheInstances()
      .map((rows) => rows.map((e) => e.toModel()).toList());

  Stream<List<EventInfoModel>> watchEventInfos() => _dao
      .watchAllEventInfos()
      .map((rows) => rows.map((e) => e.toModel()).toList());

  List<EventCacheInstanceModel> _generateInstances(EventInfoModel info) {
    final DateTime anchor = _startOfDay(info.date);
    final DateTime? start = info.start;
    final DateTime? end = info.end;

    switch (info.type) {
      case EventType.DEADLINE:
      case EventType.INTERVAL:
      case EventType.UNDEFINED:
        return [
          EventCacheInstanceModel(
            eventInfoId: info.id!,
            date: anchor,
            start: start,
            end: end,
          ),
        ];

      case EventType.MULTI_DAY:
        return _expandMultiDay(info, start, end);

      case EventType.REACCURING:
      case EventType.INDEFINITE:
        return _expandRecurring(info, start, end);
    }
  }

  DateTime _startOfDay(DateTime d) => DateTime(d.year, d.month, d.day);

  List<EventCacheInstanceModel> _expandMultiDay(
    EventInfoModel info,
    DateTime? start,
    DateTime? end,
  ) {
    if (end == null) return [];

    final DateTime firstDay = _startOfDay(start ?? info.date);
    final DateTime lastDay = _startOfDay(end);

    final List<EventCacheInstanceModel> out = [];

    DateTime cursor = firstDay;
    while (!cursor.isAfter(lastDay)) {
      out.add(
        EventCacheInstanceModel(
          eventInfoId: info.id!,
          date: cursor,
          start: start != null ? cursor : null,
          end: start != null ? cursor.add(const Duration(days: 1)) : null,
        ),
      );
      cursor = cursor.add(const Duration(days: 1));
    }

    return out;
  }

  List<EventCacheInstanceModel> _expandRecurring(
    EventInfoModel info,
    DateTime? start,
    DateTime? end, {
    int maxInstances = 100,
  }) {
    final String rule = info.rrule!;
    final parts = {
      for (final p in rule.split(';')) p.split('=').first: p.split('=').last,
    };

    final String? freq = parts['FREQ'];
    final int? count = int.tryParse(parts['COUNT'] ?? '');
    final DateTime? until = parts['UNTIL'] != null
        ? DateTime.parse(parts['UNTIL']!)
        : null;

    final DateTime baseDate = info.date;
    final DateTime cursorStart = start ?? baseDate;

    final Duration? duration = (start != null && end != null)
        ? end.difference(start)
        : null;

    final List<EventCacheInstanceModel> out = [];

    DateTime cursor = cursorStart;
    int generated = 0;

    while (true) {
      if (count != null && generated >= count) break;
      if (until != null && cursor.isAfter(until)) break;
      if (generated >= maxInstances) break;

      out.add(
        EventCacheInstanceModel(
          eventInfoId: info.id!,
          date: _startOfDay(cursor),
          start: start != null ? cursor : null,
          end: duration != null ? cursor.add(duration) : null,
        ),
      );

      generated++;

      switch (freq) {
        case 'DAILY':
          cursor = cursor.add(const Duration(days: 1));

        case 'WEEKLY':
          cursor = cursor.add(const Duration(days: 7));

        case 'MONTHLY':
          cursor = DateTime(
            cursor.year,
            cursor.month + 1,
            cursor.day,
            cursor.hour,
            cursor.minute,
          );

        default:
          return out;
      }
    }

    return out;
  }
}
