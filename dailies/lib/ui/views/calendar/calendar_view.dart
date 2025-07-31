import 'package:dailies/common/enums/time_slot_type.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/ui/views/components/add%20event/custom_floating_action_button.dart';
import 'package:dailies/ui/views/calendar/calendar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

final DateTime FIRST_CALENDAR_DAY = DateTime.utc(2003, 05, 14);
final DateTime LAST_CALENDAR_DAY = DateTime.utc(2100, 12, 31);

class EventTimeSlotPair {
  final Event event;
  final TimeSlot timeSlot;

  EventTimeSlotPair({required this.event, required this.timeSlot});
}

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        context.read<CalendarViewModel>().initialize();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CalendarViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              TableCalendar(
                headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
                focusedDay: viewModel.selectedDay,
                firstDay: FIRST_CALENDAR_DAY,
                lastDay: LAST_CALENDAR_DAY,
                sixWeekMonthsEnforced: true,
                selectedDayPredicate: (selectedDay) => isSameDay(selectedDay, viewModel.selectedDay),
                onDaySelected: (selectedDay, focusedDay) => viewModel.onDaySelect(selectedDay),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: viewModel.selectedEvents,
                  builder: (context, events, _) {
                    final flattened =
                        events.expand((event) {
                          return event.timeSlots.map((slot) => EventTimeSlotPair(event: event, timeSlot: slot));
                        }).toList();

                    if (flattened.isEmpty) {
                      return const Center(child: Text("No events"));
                    }

                    return ListView.builder(
                      itemCount: flattened.length,
                      itemBuilder: (context, index) {
                        final pair = flattened[index];
                        final event = pair.event;
                        final slot = pair.timeSlot;

                        String? timeText;
                        switch (slot.timeSlotType) {
                          case TimeSlotType.Interval:
                            timeText =
                                "${TimeOfDay.fromDateTime(slot.startTime).format(context)} - ${TimeOfDay.fromDateTime(slot.endTime).format(context)}";
                          case TimeSlotType.Deadline:
                            timeText = "Due at ${TimeOfDay.fromDateTime(slot.endTime).format(context)}";
                          case TimeSlotType.Unspecified:
                            timeText = null;
                        }

                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                          child: ListTile(
                            title: Text(event.eventName),
                            subtitle: (timeText != null) ? Text(timeText) : null,
                            onTap: () => print('Tapped: ${event.eventName} - ${slot.timeSlotType.name}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Consumer<CalendarViewModel>(
        builder: (context, viewModel, child) {
          return CustomFloatingActionButton(onButtonPress: viewModel.onAddEventButtonPress);
        },
      ),
    );
  }
}
