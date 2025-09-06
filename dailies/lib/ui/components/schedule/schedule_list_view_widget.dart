import 'package:dailies/common/utils/typedefs.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:flutter/material.dart';

class ScheduleListViewWidget extends StatelessWidget {
  final List<EventTimeSlotPair> _pairs;
  final ScheduleListBuilder _builder;

  const ScheduleListViewWidget({super.key, required List<EventTimeSlotPair> pairs, required ScheduleListBuilder builder}) : _pairs = pairs, _builder = builder;

  @override
  Widget build(BuildContext context) {
    if (_pairs.isEmpty) return _buildEmptyState(context);

    return ListView.builder(
      shrinkWrap: true,
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
        padding: UIFormating.extraLargePadding(),
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutCubic,
          builder: (context, double value, child) {
            return Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 48, color: colorScheme.onSurface.withValues(alpha: 0.4)),
                    const SizedBox(height: 16),
                    Text(
                      'Schedule is clear',
                      style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.6), fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
