import 'package:dailies/common/utils/typedefs.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:flutter/material.dart';

class ScheduleListViewWidget extends StatelessWidget {
  final List<TimeSlot> _timeSlots;
  final Map<int, Event> _idToEventMap;
  final ScheduleListBuilder _builder;

  const ScheduleListViewWidget({super.key, required List<TimeSlot> timeSlots, required Map<int, Event> idToEventMap, required ScheduleListBuilder builder})
    : _timeSlots = timeSlots,
      _idToEventMap = idToEventMap,
      _builder = builder;

  @override
  Widget build(BuildContext context) {
    if (_timeSlots.isEmpty) return _buildEmptyState(context);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _timeSlots.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return _builder(EventTimeSlotPair(first: _idToEventMap[_timeSlots[index].eventId]!, second: _timeSlots[index]));
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(color: colorScheme.primary.withAlpha(30), borderRadius: BorderRadius.circular(20)),
              child: Icon(Icons.event_note_outlined, size: 40, color: colorScheme.primary),
            ),
            const SizedBox(height: 14),
            Text('No Events', style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, color: colorScheme.onSurface)),
          ],
        ),
      ),
    );
  }
}
