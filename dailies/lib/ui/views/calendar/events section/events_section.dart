import 'package:dailies/data/models/event.dart';
import 'package:dailies/ui/components/hero_dialog_route.dart';
import 'package:dailies/ui/components/popup%20cards/delete_confirmation_popup_card.dart';
import 'package:dailies/ui/components/popup%20cards/popup_card.dart';
import 'package:dailies/ui/components/schedule/schedule_item_widget.dart';
import 'package:dailies/ui/components/schedule/schedule_list_view_widget.dart';
import 'package:dailies/ui/components/section.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/shared/calendar_view_model.dart';
import 'package:dailies/ui/views/shared/events_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsSection extends StatelessWidget {
  final EventsViewModel _eventsViewModel;
  final CalendarViewModel _calendarViewModel;

  late final VoidCallback _selectedEventsListener;

  EventsSection({super.key, required EventsViewModel eventsViewModel, required CalendarViewModel calendarViewModel})
    : _eventsViewModel = eventsViewModel,
      _calendarViewModel = calendarViewModel {
    _selectedEventsListener = () => _eventsViewModel.updateSelectedFlattenedEvents(_calendarViewModel.selectedDay);

    _calendarViewModel.selectedDayNotifier.addListener(_selectedEventsListener);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(8), blurRadius: 8, offset: const Offset(0, -2))],
      ),
      child: Padding(
        padding: const EdgeInsetsGeometry.fromLTRB(16, 0, 16, 16),
        child: ValueListenableBuilder(
          valueListenable: _eventsViewModel.selectedFlattenedEventsNotifier,
          builder: (context, pairs, _) {
            return Section(
              children: [
                SectionHeader(
                  titleWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: UIFormating.mediumPadding(),
                        decoration: BoxDecoration(color: colorScheme.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
                        child: Text(
                          DateFormat.MMMMEEEEd().format(_calendarViewModel.selectedDay),
                          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, color: colorScheme.onSurface),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final Event? newEvent = await Navigator.push(
                            context,
                            HeroDialogRoute(
                              builder: (context) {
                                return PopupCard.AddEvent(selectedDay: _calendarViewModel.selectedDay, heroTag: '');
                              },
                            ),
                          );

                          if (newEvent != null) {
                            _eventsViewModel.addEvent(newEvent);
                          }
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SectionContent(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: ScheduleListViewWidget(
                      pairs: pairs,
                      builder:
                          (pair) => InkWell(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return DeleteConfirmationDialog(
                                    itemName: pair.first.eventName,
                                    onDelete: () async {
                                      await _eventsViewModel.deleteEvent(pair.first);
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
