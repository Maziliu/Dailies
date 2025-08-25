import 'package:dailies/ui/views/overview/gacha%20section/gacha_view_model.dart';
import 'package:dailies/ui/views/shared/events_view_model.dart';
import 'package:flutter/material.dart';

class OverviewPageViewModel extends ChangeNotifier {
  final EventsViewModel _eventsViewModel;
  final GachaViewModel _staminaViewModel;

  OverviewPageViewModel({required EventsViewModel eventsViewModel, required GachaViewModel staminaViewModel})
    : _eventsViewModel = eventsViewModel,
      _staminaViewModel = staminaViewModel;

  EventsViewModel get eventsViewModel => _eventsViewModel;
  GachaViewModel get staminaViewModel => _staminaViewModel;
}
