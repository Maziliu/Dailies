import 'package:dailies_v2/ui/state/init.dart';
import 'package:dailies_v2/ui/state/upload_view_model.dart';
import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:dailies_v2/ui/views/widgets/file_list_item.dart';
import 'package:dailies_v2/ui/views/widgets/item_list.dart';
import 'package:dailies_v2/ui/views/widgets/section_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileUploadSection extends StatelessWidget {
  const FileUploadSection({super.key});

  @override
  Widget build(BuildContext context) {
    final UploadViewModel viewModel = UPLOAD_VIEW_MODEL;

    return SectionCard(
      padding: UIFormating.mediumPadding(),
      child: Column(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        children: [
          _UploadDropzone(onTap: () => {}),

          _FilesHeader(
            count: viewModel.uploadedFiles.value.length,
            onClear: viewModel.uploadedFiles.value.isNotEmpty
                ? viewModel.clearUploadedFiles
                : () => {},
          ),

          ValueListenableBuilder<List<PlatformFile>>(
            valueListenable: viewModel.uploadedFiles,
            builder: (context, files, _) {
              if (files.isEmpty) return const SizedBox.shrink();

              return Expanded(
                child: ItemList<PlatformFile>(
                  showEmptyState: false,
                  items: files,
                  itemBuilder: (file) {
                    return FileListItem(
                      file: file,
                      onRemove: () => viewModel.removeUploadedFile(file),
                    );
                  },
                ),
              );
            },
          ),

          if (true)
            _ActionButtons(
              showConfigure: viewModel.uploadedFiles.value.isNotEmpty,
              onConfigure: () => {},
              onParse: viewModel.parseAllUploadedFiles,
            ),
        ],
      ),
    );
  }
}

class _UploadDropzone extends StatelessWidget {
  final VoidCallback onTap;

  const _UploadDropzone({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.5)),
        ),
        padding: UIFormating.extraLargePadding(),
        child: Column(
          children: [
            const Icon(Icons.file_upload_outlined, color: Colors.grey),
            Text(
              'Upload Files',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final bool showConfigure;
  final VoidCallback onConfigure;
  final VoidCallback onParse;

  const _ActionButtons({
    required this.showConfigure,
    required this.onConfigure,
    required this.onParse,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showConfigure)
          Expanded(
            child: ElevatedButton(
              onPressed: onConfigure,
              child: const Text('Configure'),
            ),
          ),
        if (showConfigure) UIFormating.smallHorizontalSpacing(),
        Expanded(
          child: ElevatedButton(onPressed: onParse, child: const Text('Parse')),
        ),
      ],
    );
  }
}

class _FilesHeader extends StatelessWidget {
  final int count;
  final VoidCallback? onClear;

  const _FilesHeader({required this.count, this.onClear});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // if (count == 0) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Files ($count)', style: theme.textTheme.bodyMedium),
          // if (onClear != null)
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
