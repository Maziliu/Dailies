import 'package:dailies_v2/ui/state/calendar_view_model.dart';
import 'package:dailies_v2/ui/state/init.dart';
import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:dailies_v2/ui/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

final DateTime FIRST_CALENDAR_DAY = DateTime.utc(2003, 5, 14);
final DateTime LAST_CALENDAR_DAY = DateTime.utc(2100, 12, 31);

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarViewModel viewModel = CALENDAR_VIEW_MODEL;
    final theme = Theme.of(context);

    return SectionCard(
      padding: UIFormating.smallPadding(),
      child: ValueListenableBuilder<DateTime>(
        valueListenable: viewModel.selectedDayNotifier,
        builder: (context, selectedDay, _) {
          return TableCalendar(
            firstDay: FIRST_CALENDAR_DAY,
            lastDay: LAST_CALENDAR_DAY,
            focusedDay: selectedDay,
            rowHeight: 38,
            sixWeekMonthsEnforced: true,
            selectedDayPredicate: (day) => isSameDay(day, selectedDay),
            onDaySelected: (day, _) => viewModel.onDaySelect(day),

            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),

            calendarStyle: CalendarStyle(
              rangeHighlightColor: theme.colorScheme.primary,

              selectedDecoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),

              todayDecoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              todayTextStyle: const TextStyle(color: Colors.white),

              defaultDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              defaultTextStyle: const TextStyle(color: Colors.white),

              weekendDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              weekendTextStyle: const TextStyle(color: Colors.white70),
            ),
          );
        },
      ),
    );
  }
}
