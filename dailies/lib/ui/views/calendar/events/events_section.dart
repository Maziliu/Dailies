import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/ui/modals/add_update_event.dart';
import 'package:dailies_v2/ui/state/events_view_model.dart';
import 'package:dailies_v2/ui/state/init.dart';
import 'package:dailies_v2/ui/widgets/events_list.dart';
import 'package:dailies_v2/ui/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventsSection extends StatelessWidget {
  const EventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final calendarViewModel = CALENDAR_VIEW_MODEL;
    final eventViewModel = EVENTS_VIEW_MODEL;
    final theme = Theme.of(context);

    Future<void> onShowAddEventDialog() async {
      final result = await showDialog<EventInfoModel>(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const AddOrUpdateEventModal(),
          );
        },
      );

      if (result == null) return;

      eventViewModel.createEvent(result);
    }

    return ChangeNotifierProvider.value(
      value: EVENTS_VIEW_MODEL,
      child: SectionCard(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
        child: ValueListenableBuilder<DateTime>(
          valueListenable: calendarViewModel.selectedDayNotifier,
          builder: (context, selectedDay, _) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.MMMMEEEEd().format(selectedDay),
                        style: theme.textTheme.headlineLarge,
                      ),
                      IconButton(
                        onPressed: onShowAddEventDialog,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Consumer<EventsViewModel>(
                    builder: (context, viewModel, _) {
                      return EventsList(
                        events: viewModel.getInstancesByDate(selectedDay),
                      );
                    },
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
