import 'package:dailies/common/utils/build_context_extensions.dart';
import 'package:dailies/common/utils/typedefs.dart';
import 'package:dailies/ui/components/schedule/schedule_empty_state.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:flutter/material.dart';

class ScheduleListViewWidget extends StatelessWidget {
  final List<EventTimeSlotPair> _pairs;
  final ScheduleListBuilder _builder;

  const ScheduleListViewWidget({
    super.key,
    required List<EventTimeSlotPair> pairs,
    required ScheduleListBuilder builder,
  }) : _pairs = pairs,
       _builder = builder;

  @override
  Widget build(BuildContext context) {
    if (_pairs.isEmpty) return const ScheduleEmptyState();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _pairs.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return _builder(_pairs[index]);
      },
    );
  }
}
