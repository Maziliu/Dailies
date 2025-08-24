import 'package:dailies/ui/views/calendar/sub%20page/sections/view%20models/event_type_section_view_model.dart';
import 'package:dailies/ui/views/calendar/sub%20page/sections/view%20models/pattern_details_view_model.dart';

class AddEventFacade {
  final EventTypeSectionViewModel eventTypeSectionViewModel;
  final PatternDetailsSectionViewModel patternDetailsSectionViewModel;

  final DateTime _selectedDay;

  DateTime get selectedDay => _selectedDay;

  AddEventFacade({required DateTime selectedDay})
    : _selectedDay = selectedDay,
      eventTypeSectionViewModel = EventTypeSectionViewModel(),
      patternDetailsSectionViewModel = PatternDetailsSectionViewModel(selectedDay: selectedDay);
}
