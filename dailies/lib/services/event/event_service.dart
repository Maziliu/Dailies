import 'package:dailies_v2/database/daos/event_dao.dart';
import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/services/event/rrule_event_generator.dart';
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

  Future<Result<int>> insertEvent(EventInfoModel eventInfo) async {
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
      instances = RRuleEventGenerator.generateInstances(eventInfo);
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
}
