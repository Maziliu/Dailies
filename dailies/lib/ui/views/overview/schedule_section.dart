import 'package:dailies/common/utils/typedefs.dart';
import 'package:dailies/ui/components/schedule/schedule_item_widget.dart';
import 'package:dailies/ui/components/schedule/schedule_list_view_widget.dart';
import 'package:dailies/ui/views/shared%20view%20models/events_view_model.dart';
import 'package:flutter/material.dart';

class ScheduleSection extends StatelessWidget {
  final EventsViewModel _eventsViewModel;
  final int? _flex;

  const ScheduleSection({super.key, required EventsViewModel eventsViewModel, int? flex}) : _eventsViewModel = eventsViewModel, _flex = flex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Expanded(
      flex: _flex ?? 1,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(8), blurRadius: 8, offset: const Offset(0, -2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, textTheme, colorScheme),

            Expanded(
              child: ValueListenableBuilder<List<EventTimeSlotPair>>(
                valueListenable: _eventsViewModel.todayLoadedFlattenedEventsNotifier,
                builder: (context, pairs, _) {
                  return Container(
                    decoration: BoxDecoration(color: colorScheme.surface, borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20))),
                    child: ScheduleListViewWidget(pairs: pairs, builder: (pair) => ScheduleItemWidget(eventTimeSlotPair: pair)),
                  );
                },
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
                    Text('Today\'s Schedule', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, color: colorScheme.onSurface)),
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
    if (eventCount == 0) return 'No events scheduled';
    return '$eventCount events scheduled';
  }
}
