import 'package:dailies/presentation/views/common_widgets/custom_floating_action_button.dart';
import 'package:dailies/presentation/views/events/events_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

final DateTime FIRST_CALENDAR_DAY = DateTime.utc(2003, 05, 14);
final DateTime LAST_CALENDAR_DAY = DateTime.utc(2100, 12, 31);

class EventsView extends StatelessWidget {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EventsViewModel>(
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            Column(
              children: [
                TableCalendar(
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  focusedDay: viewModel.selectedDay,
                  firstDay: FIRST_CALENDAR_DAY,
                  lastDay: LAST_CALENDAR_DAY,
                  sixWeekMonthsEnforced: true,
                  selectedDayPredicate:
                      (selectedDay) =>
                          isSameDay(selectedDay, viewModel.selectedDay),
                  onDaySelected:
                      (selectedDay, focusedDay) =>
                          viewModel.onDaySelect(selectedDay),
                ),
              ],
            ),

            CustomFloatingActionButton(
              onButtonPress: viewModel.onAddEventButtonPress,
            ),
          ],
        );
      },
    );
  }
}
