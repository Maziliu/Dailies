import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/ui/views/overview/overview_view.dart';
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
            child: ItemList<EventModel>(
              items: fakeTodayEvents(),
              itemBuilder: (event) {
                return ScheduleItem(
                  title: event.title,
                  start: event.start,
                  end: event.resolvedEnd,
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
