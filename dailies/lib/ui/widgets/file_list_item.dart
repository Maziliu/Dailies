import 'package:dailies_v2/enums/parse_progress.dart';
import 'package:dailies_v2/ui/state/upload_view_model.dart';
import 'package:dailies_v2/utils/utils.dart';
import 'package:flutter/material.dart';

class FileListItem extends StatelessWidget {
  final PlatformFileWithProgress file;
  final VoidCallback onRemove;
  final VoidCallback onRetryParse;

  const FileListItem({
    super.key,
    required this.file,
    required this.onRemove,
    required this.onRetryParse,
  });

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _FileInfo(file: file)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _StatusIcon(progress: file.parseProgress),
                const SizedBox(width: 8),
                if (file.parseProgress == null)
                  InkWell(
                    onTap: onRemove,
                    child: const Icon(Icons.close, color: Colors.grey),
                  ),
                if (file.parseProgress == ParseProgress.FAILED)
                  InkWell(
                    onTap: onRetryParse,
                    child: const Icon(
                      Icons.cached_rounded,
                      color: Colors.white38,
                    ),
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
  final PlatformFileWithProgress file;

  const _FileInfo({required this.file});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final platformFile = file.file;

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: _FileTypeIcon(extension: platformFile.extension),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                platformFile.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headlineMedium,
              ),
              Text(
                'Size: ${formatFileSize(platformFile.size)}',
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

class _StatusIcon extends StatelessWidget {
  final ParseProgress? progress;

  const _StatusIcon({this.progress});

  @override
  Widget build(BuildContext context) {
    switch (progress) {
      case ParseProgress.IN_PROGRESS:
        return const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      case ParseProgress.COMPLETED:
        return const Icon(Icons.check_circle, color: Colors.green);
      case ParseProgress.FAILED:
        return const Icon(Icons.error, color: Colors.red);
      default:
        return const SizedBox.shrink();
    }
  }
}
