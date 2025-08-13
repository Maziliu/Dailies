import 'package:dailies/common/utils/typedefs.dart';
import 'package:flutter/material.dart';

class ScheduleListViewWidget extends StatelessWidget {
  final List<EventTimeSlotPair> _pairs;
  final ScheduleListBuilder _builder;

  const ScheduleListViewWidget({super.key, required List<EventTimeSlotPair> pairs, required ScheduleListBuilder builder}) : _pairs = pairs, _builder = builder;

  @override
  Widget build(BuildContext context) {
    if (_pairs.isEmpty) return _buildEmptyState(context);

    return ListView.builder(
      itemCount: _pairs.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return _builder(_pairs[index]);
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
            Text('No Events', style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600, color: colorScheme.onSurface)),
          ],
        ),
      ),
    );
  }
}
