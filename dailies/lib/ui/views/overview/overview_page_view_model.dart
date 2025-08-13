import 'package:dailies/ui/mixins/page_view_model_mixin.dart';
import 'package:dailies/ui/views/overview/gacha%20section/gacha_view_model.dart';
import 'package:dailies/ui/views/shared/events_view_model.dart';
import 'package:flutter/material.dart';

class OverviewPageViewModel extends ChangeNotifier with PageViewModelMixin {
  final EventsViewModel _eventsViewModel;
  final GachaViewModel _staminaViewModel;

  late final VoidCallback _eventsViewModelListener;
  late final VoidCallback _staminaViewModelListener;

  OverviewPageViewModel({required EventsViewModel eventsViewModel, required GachaViewModel staminaViewModel})
    : _eventsViewModel = eventsViewModel,
      _staminaViewModel = staminaViewModel {
    _eventsViewModelListener = () => updateErrorMessages(eventsViewModel.viewModelErrors.value);
    _staminaViewModelListener = () => updateErrorMessages(staminaViewModel.viewModelErrors.value);

    eventsViewModel.viewModelErrors.addListener(_eventsViewModelListener);
    staminaViewModel.viewModelErrors.addListener(_staminaViewModelListener);
  }

  EventsViewModel get eventsViewModel => _eventsViewModel;
  GachaViewModel get staminaViewModel => _staminaViewModel;
}
