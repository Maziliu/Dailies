import 'package:dailies/data/models/event.dart';
import 'package:dailies/service/repository/event_repository_service.dart';
import 'package:dailies/ui/mixins/error_stream_mixin.dart';
import 'package:flutter/material.dart';

class ParsedEventsViewModel extends ChangeNotifier with ErrorStreamMixin {
  final EventRepositoryService _eventRepositoryService;
  final ValueNotifier<List<Event>> foundEvents = ValueNotifier([]);

  ParsedEventsViewModel({required EventRepositoryService eventRepositoryService}) : _eventRepositoryService = eventRepositoryService;

  Future<void> saveAllEvents() async {
    for (final Event event in foundEvents.value) {
      await _eventRepositoryService.saveEvent(event);
    }
  }
}
