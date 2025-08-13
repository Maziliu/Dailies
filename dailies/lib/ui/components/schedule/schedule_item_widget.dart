import 'package:dailies/common/enums/time_slot_type.dart';
import 'package:dailies/common/utils/typedefs.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:flutter/material.dart';

class ScheduleItemWidget extends StatelessWidget {
  final EventTimeSlotPair _eventTimeSlotPair;

  const ScheduleItemWidget({super.key, required EventTimeSlotPair eventTimeSlotPair}) : _eventTimeSlotPair = eventTimeSlotPair;

  @override
  Widget build(BuildContext context) {
    final Event event = _eventTimeSlotPair.first;
    final TimeSlot timeSlot = _eventTimeSlotPair.second;
    final String? timeText = _formatTimeText(context, timeSlot);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final Color eventColour = _getEventColour(timeSlot.timeSlotType, colorScheme);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline.withAlpha(50), width: 1),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(12), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: eventColour.withAlpha(40), borderRadius: BorderRadius.circular(8)),
              child: Icon(_getIconForTimeSlotType(timeSlot.timeSlotType), color: eventColour, size: 20),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    event.eventName,
                    style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: colorScheme.onSurface),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  if (timeText != null) ...[
                    const SizedBox(height: 4),
                    Text(timeText, style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withAlpha(160), fontWeight: FontWeight.w500)),
                  ],

                  if (event.location?.isNotEmpty == true) ...[
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.place_rounded, size: 14, color: colorScheme.onSurface.withAlpha(120)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            event.location!,
                            style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurface.withAlpha(120)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            if (event.isRecurring) Icon(Icons.sync_rounded, size: 16, color: colorScheme.onSurface.withAlpha(120)),
          ],
        ),
      ),
    );
  }

  String? _formatTimeText(BuildContext context, TimeSlot slot) {
    switch (slot.timeSlotType) {
      case TimeSlotType.Interval:
        return "${TimeOfDay.fromDateTime(slot.startTime!).format(context)} - "
            "${TimeOfDay.fromDateTime(slot.endTime!).format(context)}";
      case TimeSlotType.Deadline:
        return "Due ${TimeOfDay.fromDateTime(slot.endTime!).format(context)}";
      default:
        return null;
    }
  }

  IconData _getIconForTimeSlotType(TimeSlotType type) {
    switch (type) {
      case TimeSlotType.Interval:
        return Icons.access_time_rounded;
      case TimeSlotType.Deadline:
        return Icons.today_rounded;
      case TimeSlotType.Unspecified:
        return Icons.all_inclusive;
    }
  }

  Color _getEventColour(TimeSlotType type, ColorScheme colorScheme) {
    switch (type) {
      case TimeSlotType.Interval:
        return const Color(0xFF6366F1);
      case TimeSlotType.Deadline:
        return const Color(0xFFEC4899);
      case TimeSlotType.Unspecified:
        return colorScheme.primary;
    }
  }
}
