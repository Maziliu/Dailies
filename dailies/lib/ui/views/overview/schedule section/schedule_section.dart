import 'package:dailies/common/utils/typedefs.dart';
import 'package:dailies/ui/components/section.dart';
import 'package:dailies/ui/components/schedule/schedule_item_widget.dart';
import 'package:dailies/ui/components/schedule/schedule_list_view_widget.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/shared/events_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleSection extends StatelessWidget {
  final EventsViewModel _eventsViewModel;

  const ScheduleSection({super.key, required EventsViewModel eventsViewModel}) : _eventsViewModel = eventsViewModel;

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
        padding: UIFormating.mediumPadding(),
        child: Section(
          children: [
            SectionHeader(titleWidget: _buildHeader(context, textTheme, colorScheme)),
            Expanded(
              child: SectionContent(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: ValueListenableBuilder<List<EventTimeSlotPair>>(
                  valueListenable: _eventsViewModel.todayLoadedFlattenedEventsNotifier,
                  builder: (context, pairs, _) {
                    return ScheduleListViewWidget(pairs: pairs, builder: (pair) => ScheduleItemWidget(eventTimeSlotPair: pair));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TextTheme textTheme, ColorScheme colorScheme) {
    return ValueListenableBuilder<List<EventTimeSlotPair>>(
      valueListenable: _eventsViewModel.todayLoadedFlattenedEventsNotifier,
      builder: (context, pairs, _) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
          decoration: BoxDecoration(color: colorScheme.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, color: colorScheme.onSurface),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _getSubtitleText(pairs.length),
                      style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurface.withAlpha(140), fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: pairs.isEmpty ? colorScheme.outline.withAlpha(30) : colorScheme.primary.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  pairs.length.toString(),
                  style: textTheme.labelMedium?.copyWith(
                    color: pairs.isEmpty ? colorScheme.onSurface.withAlpha(120) : colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getSubtitleText(int eventCount) {
    if (eventCount == 0) return 'No events';
    return '$eventCount events';
  }
}
