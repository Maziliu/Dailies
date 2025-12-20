import 'package:dailies_v2/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileListItem extends StatelessWidget {
  final PlatformFile file;
  final VoidCallback onRemove;

  const FileListItem({super.key, required this.file, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
        child: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _FileInfo(file: file)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: onRemove,
                  child: const Icon(Icons.close, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FileInfo extends StatelessWidget {
  final PlatformFile file;

  const _FileInfo({required this.file});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: _FileTypeIcon(extension: file.extension),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                file.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headlineMedium,
              ),
              Text(
                'Size: ${formatFileSize(file.size)}',
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FileTypeIcon extends StatelessWidget {
  final String? extension;

  const _FileTypeIcon({this.extension});

  @override
  Widget build(BuildContext context) {
    switch (extension) {
      case 'pdf':
        return const Icon(Icons.picture_as_pdf, size: 30, color: Colors.red);
      case 'ics':
        return const Icon(Icons.calendar_today, size: 30);
      default:
        return const Icon(Icons.file_copy, size: 30);
    }
  }
}
