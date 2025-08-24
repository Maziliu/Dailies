import 'package:dailies/ui/components/section.dart';
import 'package:dailies/ui/components/ui_formating.dart';
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
    return Padding(
      padding: UIFormating.mediumPadding(),
      child: Section(
        children: [
          SectionContent(
            child: ValueListenableBuilder(
              valueListenable: _calendarViewModel.selectedDayNotifier,
              builder: (context, selectedDay, _) {
                return TableCalendar(
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
          ),
        ],
      ),
    );
  }
}
