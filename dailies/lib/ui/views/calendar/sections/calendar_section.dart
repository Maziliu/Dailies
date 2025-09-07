import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/themes/themes.dart';
import 'package:dailies/ui/views/shared/calendar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

final DateTime FIRST_CALENDAR_DAY = DateTime.utc(2003, 05, 14);
final DateTime LAST_CALENDAR_DAY = DateTime.utc(2100, 12, 31);

class CalendarSection extends StatelessWidget {
  final CalendarViewModel _calendarViewModel;

  const CalendarSection({super.key, required CalendarViewModel calendarViewModel}) : _calendarViewModel = calendarViewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIFormating.smallPadding(),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color.fromRGBO(158, 158, 158, 0.5))),
      child: ValueListenableBuilder(
        valueListenable: _calendarViewModel.selectedDayNotifier,
        builder: (context, selectedDay, _) {
          return TableCalendar(
            calendarStyle: CalendarStyle(
              rangeHighlightColor: UI_ELEMENTS_BACKGROUND_COLOUR,
              selectedDecoration: const BoxDecoration(color: UI_ELEMENTS_BACKGROUND_COLOUR, shape: BoxShape.circle),
              selectedTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              todayDecoration: BoxDecoration(color: UI_ELEMENTS_BACKGROUND_COLOUR.withValues(alpha: 0.4), shape: BoxShape.circle),
              todayTextStyle: const TextStyle(color: Colors.white),
              defaultDecoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
              defaultTextStyle: const TextStyle(color: Colors.white),
              weekendDecoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
              weekendTextStyle: const TextStyle(color: Colors.white70),
            ),
            headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
            focusedDay: selectedDay,
            firstDay: FIRST_CALENDAR_DAY,
            lastDay: LAST_CALENDAR_DAY,
            sixWeekMonthsEnforced: true,
            selectedDayPredicate: (day) => isSameDay(day, selectedDay),
            onDaySelected: (day, _) => _calendarViewModel.onDaySelect(day),
          );
        },
      ),
    );
  }
}
