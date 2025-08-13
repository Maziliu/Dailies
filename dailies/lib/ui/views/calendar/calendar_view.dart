import 'package:dailies/common/enums/time_slot_type.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/dependency_setup.dart';
import 'package:dailies/service/repository/event_repository_service.dart';
import 'package:dailies/ui/components/hero_dialog_route.dart';
import 'package:dailies/ui/components/popup%20cards/delete_confirmation_popup_card.dart';
import 'package:dailies/ui/components/popup%20cards/popup_card.dart';
import 'package:dailies/ui/components/schedule/schedule_item_widget.dart';
import 'package:dailies/ui/components/schedule/schedule_list_view_widget.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/calendar/calendar_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

final DateTime FIRST_CALENDAR_DAY = DateTime.utc(2003, 05, 14);
final DateTime LAST_CALENDAR_DAY = DateTime.utc(2100, 12, 31);
final String ADD_EVENT_HERO_TAG = 'addEventHeroTag';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late final CalendarPageViewModel pageViewModel;

  @override
  void initState() {
    super.initState();

    pageViewModel = injector<CalendarPageViewModel>();
  }

  @override
  void dispose() {
    pageViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: pageViewModel,
      child: Consumer<CalendarPageViewModel>(
        builder: (context, viewModel, _) {
          return Padding(
            padding: UIFormating.smallPadding(),
            child: Scaffold(
              body: Column(
                children: [
                  TableCalendar(
                    headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
                    focusedDay: viewModel.calendarViewModel.selectedDay,
                    firstDay: FIRST_CALENDAR_DAY,
                    lastDay: LAST_CALENDAR_DAY,
                    sixWeekMonthsEnforced: true,
                    selectedDayPredicate: (day) => isSameDay(day, viewModel.calendarViewModel.selectedDay),
                    onDaySelected: (selectedDay, _) => viewModel.onDaySelect(selectedDay),
                  ),
                  UIFormating.smallVerticalSpacing(),
                  Expanded(
                    child:
                        viewModel.flattenedEvents.isEmpty
                            ? const Center(child: Text("No events"))
                            : ScheduleListViewWidget(
                              pairs: viewModel.flattenedEvents,
                              builder:
                                  (pair) => InkWell(
                                    onLongPress: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return DeleteConfirmationDialog(
                                            itemName: pair.first.eventName,
                                            onDelete: () async {
                                              await viewModel.deleteEvent(pair.first);
                                            },
                                          );
                                        },
                                      );
                                    },
                                    onTap: () => print('Tapped: ${pair.first.eventName} - ${pair.second.timeSlotType.name}'),
                                    child: ScheduleItemWidget(eventTimeSlotPair: pair),
                                  ),
                            ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                elevation: 0,
                heroTag: ADD_EVENT_HERO_TAG,
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(
                    HeroDialogRoute(
                      builder: (context) {
                        return PopupCard.AddEvent(
                          onSubmit: viewModel.onAddEvent,
                          selectedDay: viewModel.calendarViewModel.selectedDay,
                          heroTag: ADD_EVENT_HERO_TAG,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
