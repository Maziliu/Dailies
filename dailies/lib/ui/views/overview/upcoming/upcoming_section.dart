import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/ui/state/events_view_model.dart';
import 'package:dailies_v2/ui/widgets/item_list.dart';
import 'package:dailies_v2/ui/widgets/schedule_list_item.dart';
import 'package:dailies_v2/ui/widgets/section_card.dart';
import 'package:dailies_v2/utils/constants.dart';
import 'package:flutter/material.dart';

class UpcomingSection extends StatelessWidget {
  const UpcomingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SectionCard(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.fromLTRB(4, 8, 4, 8),
            child: Text('Upcoming', style: theme.textTheme.headlineLarge),
          ),
          SizedBox(
            height: MAX_SECTION_HEIGHT,
            child: ItemList<EventUIModel>(
              items: EVENTS_VIEW_MODEL.getInstancesByDateRangeInclusive(
                DateTime.now(),
                DateTime.now().add(Duration(days: 14)),
              ),
              itemBuilder: (event) {
                return ScheduleItem(
                  date: event.date,
                  title: event.title,
                  start: event.start,
                  end: event.end,
                  location: event.location,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
