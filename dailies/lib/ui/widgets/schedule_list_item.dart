import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleItem extends StatelessWidget {
  final String title;
  final DateTime date;
  final DateTime? start;
  final DateTime? end;
  final String? location;
  final bool showDate;

  const ScheduleItem({
    super.key,
    required this.title,
    required this.date,
    this.start,
    this.end,
    this.location,
    this.showDate = false,
  });

  @override
  Widget build(BuildContext context) {
    final timeText = _formatTime(context);

    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: UIFormating.mediumPadding(),
        child: Row(
          children: [
            _LeadingIcon(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (location?.isNotEmpty == true)
                    Text(
                      location!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (timeText != null)
                    Text(
                      timeText,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                ],
              ),
            ),
            if (showDate) _DateBadge(start: start ?? date),
          ],
        ),
      ),
    );
  }

  String? _formatTime(BuildContext context) {
    if (start == null) return null;

    final startText = TimeOfDay.fromDateTime(start!).format(context);

    if (end == null) return startText;

    final endText = TimeOfDay.fromDateTime(end!).format(context);
    return '$startText – $endText';
  }
}

class _LeadingIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: UIFormating.smallCircularBorderRadius(),
      ),
      child: Icon(Icons.access_time_rounded, color: color, size: 30),
    );
  }
}

class _DateBadge extends StatelessWidget {
  final DateTime start;

  const _DateBadge({required this.start});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          DateFormat.MMM().format(start),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          DateFormat.d().format(start),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
