import 'package:dailies/common/enums/time_slot_type.dart';
import 'package:dailies/common/utils/typedefs.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleItemWidget extends StatelessWidget {
  final EventTimeSlotPair _eventTimeSlotPair;
  final bool _showDate;

  const ScheduleItemWidget({super.key, required EventTimeSlotPair eventTimeSlotPair, bool showDate = false})
    : _eventTimeSlotPair = eventTimeSlotPair,
      _showDate = showDate;

  @override
  Widget build(BuildContext context) {
    final Event event = _eventTimeSlotPair.first;
    final TimeSlot timeSlot = _eventTimeSlotPair.second;
    final String? timeText = _formatTimeText(context, timeSlot);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final Color eventColour = _getEventColour(timeSlot.timeSlotType, colorScheme);

    return Card(
      elevation: 0,
      color: Colors.black26,
      child: Padding(
        padding: UIFormating.mediumPadding(),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              width: 45,
              height: 45,
              decoration: BoxDecoration(color: eventColour.withAlpha(40), borderRadius: UIFormating.smallCircularBorderRadius()),
              child: Icon(_getIconForTimeSlotType(timeSlot.timeSlotType), color: eventColour, size: 30),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(event.eventName, style: textTheme.headlineMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                  if (event.location?.isNotEmpty == true) Text(event.location!, style: textTheme.bodyMedium, overflow: TextOverflow.ellipsis),
                  if (timeText != null) Text(timeText, style: textTheme.bodyMedium),
                ],
              ),
            ),
            UIFormating.mediumHorizontalSpacing(),
            if (_showDate)
              Column(
                children: [
                  Text(DateFormat.MMM().format(timeSlot.dateOfTimeSlot), style: textTheme.bodyMedium),
                  Text(DateFormat.d().format(timeSlot.dateOfTimeSlot), style: textTheme.bodyMedium),
                ],
              ),
          ],
        ),
      ),
    );
  }

  String? _formatTimeText(BuildContext context, TimeSlot slot) {
    switch (slot.timeSlotType) {
      case TimeSlotType.Interval:
        return '${TimeOfDay.fromDateTime(slot.startTime!).format(context)} - '
            "${(slot.endTime == null) ? '' : TimeOfDay.fromDateTime(slot.endTime!).format(context)}";
      case TimeSlotType.Deadline:
        return 'Due ${TimeOfDay.fromDateTime(slot.endTime!).format(context)}';
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
      default:
        return Icons.question_mark;
    }
  }

  Color _getEventColour(TimeSlotType type, ColorScheme colorScheme) {
    switch (type) {
      case TimeSlotType.Interval:
        return const Color(0xFF6366F1);
      case TimeSlotType.Deadline:
        return const Color.fromARGB(255, 228, 30, 129);
      case TimeSlotType.Unspecified:
        return colorScheme.primary;
      default:
        return colorScheme.error;
    }
  }
}
