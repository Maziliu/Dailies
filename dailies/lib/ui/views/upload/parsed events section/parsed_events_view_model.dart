import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/service/repository/event_repository_service.dart';
import 'package:dailies/ui/mixins/error_stream_mixin.dart';
import 'package:dailies/ui/views/shared/events_view_model.dart';
import 'package:flutter/material.dart';

class ParsedEventsViewModel extends ChangeNotifier with ErrorStreamMixin {
  final EventRepositoryService _eventRepositoryService;
  final EventsViewModel _eventsViewModel;
  final ValueNotifier<List<Event>> foundEvents = ValueNotifier([]);

  ParsedEventsViewModel({required EventRepositoryService eventRepositoryService, required EventsViewModel eventsViewModel})
    : _eventRepositoryService = eventRepositoryService,
      _eventsViewModel = eventsViewModel;

  Future<void> saveAllEvents() async {
    for (final Event event in foundEvents.value) {
      Result result = await _eventRepositoryService.saveEvent(event);
      if (result is Error) emitError(result.error);
    }

    foundEvents.value = [];
    _eventsViewModel.refresh();
  }
}
