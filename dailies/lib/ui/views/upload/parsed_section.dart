import 'package:dailies_v2/ui/state/init.dart';
import 'package:dailies_v2/ui/state/upload_view_model.dart';
import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:dailies_v2/ui/widgets/events_list.dart';
import 'package:dailies_v2/ui/widgets/item_list.dart';
import 'package:dailies_v2/ui/widgets/schedule_list_item.dart';
import 'package:dailies_v2/ui/widgets/section_card.dart';
import 'package:flutter/material.dart';

class ParsedSection extends StatelessWidget {
  const ParsedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final UploadViewModel viewModel = UPLOAD_VIEW_MODEL;

    return SectionCard(
      padding: UIFormating.mediumPadding(),
      child: ValueListenableBuilder(
        valueListenable: viewModel.parsedEvents,
        builder: (context, events, _) {
          return Column(
            children: [
              _Header(
                count: events.length,
                onClear: events.isEmpty ? null : viewModel.clearParsedEvents,
              ),

              Expanded(child: EventsList(events: events)),

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
            child: ElevatedButton(onPressed: () {}, child: const Text('Edit')),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () async {},
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
