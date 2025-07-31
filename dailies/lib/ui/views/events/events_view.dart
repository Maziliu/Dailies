import 'package:dailies/common/enums/time_slot_type.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/ui/views/common_widgets/custom_floating_action_button.dart';
import 'package:dailies/ui/views/events/events_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

final DateTime FIRST_CALENDAR_DAY = DateTime.utc(2003, 05, 14);
final DateTime LAST_CALENDAR_DAY = DateTime.utc(2100, 12, 31);

class EventsView extends StatefulWidget {
  const EventsView({super.key});

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        context.read<EventsViewModel>().initialize();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<EventsViewModel>(
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
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: viewModel.selectedEvents,
                  builder: (context, events, _) {
                    if (events.isEmpty) {
                      return const Center(child: Text("No events"));
                    }

                    return ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        final timeSlots = event.timeSlots;

                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                          child: ListTile(
                            title: Text(event.eventName),
                            subtitle: Text(
                              timeSlots
                                  .map((slot) {
                                    switch (slot.timeSlotType) {
                                      case TimeSlotType.Interval:
                                        return "${TimeOfDay.fromDateTime(slot.startTime).format(context)} - ${TimeOfDay.fromDateTime(slot.endTime).format(context)}";
                                      case TimeSlotType.Deadline:
                                        return "Due at ${TimeOfDay.fromDateTime(slot.endTime).format(context)}";
                                      case TimeSlotType.AllDay:
                                        return "";
                                    }
                                  })
                                  .join(", "),
                            ),
                            onTap: () => print('Tapped: ${event.eventName}'),
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
      floatingActionButton: Consumer<EventsViewModel>(
        builder: (context, viewModel, child) {
          return CustomFloatingActionButton(onButtonPress: viewModel.onAddEventButtonPress);
        },
      ),
    );
  }
}
