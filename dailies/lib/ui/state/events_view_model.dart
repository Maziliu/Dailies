import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/services/event/event_service.dart';
import 'package:dailies_v2/utils/result.dart';
import 'package:flutter/foundation.dart';

typedef EventMapHeap =
    Map<DateTime, HeapPriorityQueue<EventCacheInstanceModel>>;

class EventsViewModel extends ChangeNotifier {
  final ValueNotifier<bool> isLoaded = ValueNotifier(false);

  final EventService _eventService = EventService();

  final Map<int, EventInfoModel> _eventInfosById = {};

  final EventMapHeap eventMapHeap = {};

  StreamSubscription? _infoSub;
  StreamSubscription? _instanceSub;

  EventsViewModel() {
    _bindStreams();
  }

  void _bindStreams() {
    _infoSub = _eventService.watchEventInfos().listen(_onInfos);
    _instanceSub = _eventService.watchEventCacheInstances().listen(
      _onInstances,
    );
  }

  void _onInfos(List<EventInfoModel> infos) {
    _eventInfosById
      ..clear()
      ..addEntries(infos.map((e) => MapEntry(e.id!, e)));

    notifyListeners();
  }

  void _onInstances(List<EventCacheInstanceModel> instances) {
    eventMapHeap.clear();

    for (final instance in instances) {
      _pushInstanceToHeap(instance);
    }

    isLoaded.value = true;
    notifyListeners();
  }

  List<EventUIModel> getInstancesByDate(DateTime date) {
    final key = DateTime(date.year, date.month, date.day);
    return eventMapHeap[key]
            ?.toList()
            .map(
              (e) => EventUIModel.fromInfoAndInstance(
                info: _eventInfosById[e.eventInfoId]!,
                instance: e,
              ),
            )
            .toList() ??
        [];
  }

  List<EventUIModel> getInstancesByDateRangeInclusive(
    DateTime lower,
    DateTime upper,
  ) {
    final lowerKey = DateTime(lower.year, lower.month, lower.day);
    final upperKey = DateTime(upper.year, upper.month, upper.day);

    final List<EventCacheInstanceModel> out = [];

    for (final entry in eventMapHeap.entries) {
      final d = entry.key;

      if (d.compareTo(lowerKey) < 0) continue;
      if (d.compareTo(upperKey) > 0) continue;

      for (final instance in entry.value.toList()) {
        out.add(instance);
      }
    }

    out.sort((a, b) => a.compareTo(b));
    return out
        .map(
          (e) => EventUIModel.fromInfoAndInstance(
            instance: e,
            info: _eventInfosById[e.eventInfoId]!,
          ),
        )
        .toList();
  }

  EventInfoModel? getEventInfo(int eventInfoId) {
    return _eventInfosById[eventInfoId];
  }

  Future<void> deleteAllEventsInSeries(int? eventInfoId) async {
    final result = await _eventService.deleteAllEventsInSeries(eventInfoId);

    switch (result) {
      case Ok<void>():
        print('OK');
      case Error<void>(failure: final Failure error):
        print(error.message);
    }
  }

  Future<void> deleteEventInstance(int? instanceId) async {
    final result = await _eventService.deleteEventInstance(instanceId);

    switch (result) {
      case Ok<void>():
        print('OK');
      case Error<void>(failure: final Failure error):
        print(error.message);
    }
  }

  Future<void> createEvent(EventInfoModel eventInfo) async {
    final result = await _eventService.insertEvent(eventInfo);

    switch (result) {
      case Ok<int>(value: final int id):
        print('INSERTED $id');
      case Error<void>(failure: final Failure error):
        print(error.message);
    }
  }

  void _pushInstanceToHeap(EventCacheInstanceModel instance) {
    final date = DateTime(
      instance.date.year,
      instance.date.month,
      instance.date.day,
    );

    eventMapHeap.putIfAbsent(date, HeapPriorityQueue.new).add(instance);
  }

  @override
  void dispose() {
    _infoSub?.cancel();
    _instanceSub?.cancel();
    super.dispose();
  }
}
