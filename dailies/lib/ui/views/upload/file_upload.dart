import 'package:dailies_v2/ui/state/init.dart';
import 'package:dailies_v2/ui/state/upload_view_model.dart';
import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:dailies_v2/ui/widgets/file_list_item.dart';
import 'package:dailies_v2/ui/widgets/item_list.dart';
import 'package:dailies_v2/ui/widgets/section_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

final List<String> ALLOWED_FILES = ['ics', 'pdf', 'txt'];

class FileUploadSection extends StatelessWidget {
  const FileUploadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      padding: UIFormating.mediumPadding(),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _UploadDropzone(
            onTap: () async {
              final FilePickerResult? result = await FilePicker.platform
                  .pickFiles(
                    type: FileType.custom,
                    allowMultiple: true,
                    allowedExtensions: ALLOWED_FILES,
                  );
              if (result == null) {
                return;
              }

              UPLOAD_VIEW_MODEL.uploadedFiles.value = result.files
                  .map((file) => PlatformFileWithProgress(file: file))
                  .toList();
            },
          ),

          Expanded(
            child: ValueListenableBuilder<List<PlatformFileWithProgress>>(
              valueListenable: UPLOAD_VIEW_MODEL.uploadedFiles,
              builder: (context, files, _) {
                return Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _FilesHeader(
                      count: files.length,
                      onClear: files.isNotEmpty
                          ? UPLOAD_VIEW_MODEL.clearUploadedFiles
                          : null,
                    ),

                    Expanded(
                      child: ItemList<PlatformFileWithProgress>(
                        showEmptyState: false,
                        items: files,
                        itemBuilder: (file) => FileListItem(
                          file: file,
                          onRemove: () =>
                              UPLOAD_VIEW_MODEL.removeUploadedFile(file.file),
                          onRetryParse: () =>
                              UPLOAD_VIEW_MODEL.retryParseFile(file),
                        ),
                      ),
                    ),

                    if (files.isNotEmpty) ...[
                      ElevatedButton(
                        onPressed: UPLOAD_VIEW_MODEL.parseAllUploadedFiles,
                        child: const Text('Parse'),
                      ),
                    ],
                  ],
                );
              },
            ),
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
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
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
