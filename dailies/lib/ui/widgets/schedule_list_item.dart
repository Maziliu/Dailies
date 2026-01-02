import 'package:dailies_v2/enums/event_type.dart';
import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleItem extends StatelessWidget {
  final String title;
  final DateTime date;
  final DateTime? start;
  final DateTime? end;
  final String? location;
  final EventType type;
  final bool showDate, disableOnHold, isAlternateTapMode;
  final VoidCallback? onHold, onTap, onTapAlternate;

  const ScheduleItem({
    super.key,
    required this.onHold,
    required this.onTap,
    required this.onTapAlternate,
    required this.isAlternateTapMode,
    required this.title,
    required this.date,
    required this.type,
    this.start,
    this.end,
    this.location,
    this.showDate = false,
    this.disableOnHold = false,
  });

  @override
  Widget build(BuildContext context) {
    final timeText = _formatTime(context);
    final ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: isAlternateTapMode ? onTapAlternate : onTap,
      onLongPress: disableOnHold ? null : onHold,
      child: Card(
        elevation: 0,
        color: theme.colorScheme.surface,
        child: Padding(
          padding: UIFormating.mediumPadding(),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.15),
                  borderRadius: UIFormating.smallCircularBorderRadius(),
                ),
                child: _getLeadingIcon(context),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.headlineMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (location?.isNotEmpty == true)
                      Text(
                        location!,
                        style: theme.textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (timeText != null)
                      Text(timeText, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),

              UIFormating.smallHorizontalSpacing(),
              if (showDate) _DateBadge(start: date),
            ],
          ),
        ),
      ),
    );
  }

  String? _formatTime(BuildContext context) {
    final String? startText = (start != null)
        ? TimeOfDay.fromDateTime(start!).format(context)
        : null;

    final String? endText = (end != null)
        ? TimeOfDay.fromDateTime(end!).format(context)
        : null;

    switch (type) {
      case EventType.DEADLINE:
        return 'Due at $endText';
      case EventType.REACCURING:
      case EventType.INTERVAL:
        return '$startText - $endText';

      default:
        return null;
    }
  }

  Widget _getLeadingIcon(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    late IconData innerIcon;
    late Color iconColour;

    switch (type) {
      case EventType.DEADLINE:
        innerIcon = Icons.today_rounded;
        iconColour = const Color.fromARGB(170, 228, 30, 129);
      case EventType.REACCURING:
      case EventType.INTERVAL:
        innerIcon = Icons.access_time_rounded;
        iconColour = const Color(0xFF6366F1);

      default:
        innerIcon = Icons.question_mark;
        iconColour = theme.colorScheme.primary;
    }

    return Icon(innerIcon, color: iconColour, size: 30);
  }
}

class _DateBadge extends StatelessWidget {
  final DateTime start;

  const _DateBadge({required this.start});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Text(DateFormat.MMM().format(start), style: theme.textTheme.bodyMedium),
        Text(DateFormat.d().format(start), style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
