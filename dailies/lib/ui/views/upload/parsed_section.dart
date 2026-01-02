import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/ui/state/init.dart';
import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:dailies_v2/ui/widgets/events_list.dart';
import 'package:dailies_v2/ui/widgets/section_card.dart';
import 'package:flutter/material.dart';

class ParsedSection extends StatelessWidget {
  const ParsedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      padding: UIFormating.mediumPadding(),
      child: ValueListenableBuilder(
        valueListenable: UPLOAD_VIEW_MODEL.parsedEvents,
        builder: (context, events, _) {
          return Column(
            spacing: 8,
            children: [
              _Header(
                count: events.length,
                onClear: events.isEmpty
                    ? null
                    : UPLOAD_VIEW_MODEL.clearParsedEvents,
              ),

              Expanded(
                child: EventsList(
                  disableOnHold: true,
                  showDate: true,
                  events: events
                      .map((e) => EventUIModel.fromEventInfo(info: e))
                      .toList(),
                ),
              ),

              if (events.isNotEmpty) _buildActionButtons(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: UPLOAD_VIEW_MODEL.addParsedToCalendar,
              child: const Text('Add Events'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final int count;
  final VoidCallback? onClear;

  const _Header({required this.count, this.onClear});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Found ($count)', style: theme.textTheme.bodyMedium),
          if (onClear != null)
            InkWell(
              onTap: onClear,
              child: Text(
                'Clear',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
