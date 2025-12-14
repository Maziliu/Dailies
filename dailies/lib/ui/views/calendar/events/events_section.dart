import 'package:dailies_v2/ui/state/calendar_view_model.dart';
import 'package:dailies_v2/ui/state/init.dart';
import 'package:dailies_v2/ui/views/overview/overview_view.dart';
import 'package:dailies_v2/ui/views/widgets/events_list.dart';
import 'package:dailies_v2/ui/views/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsSection extends StatelessWidget {
  const EventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarViewModel viewModel = CALENDAR_VIEW_MODEL;
    final ThemeData theme = Theme.of(context);

    return SectionCard(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: ValueListenableBuilder<DateTime>(
        valueListenable: viewModel.selectedDayNotifier,
        builder: (context, selectedDay, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsetsGeometry.fromLTRB(8, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat.MMMMEEEEd().format(selectedDay),
                      style: theme.textTheme.headlineLarge,
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                  ],
                ),
              ),
              Expanded(child: EventsList(events: fakeTodayEvents())),
            ],
          );
        },
      ),
    );
  }
}
