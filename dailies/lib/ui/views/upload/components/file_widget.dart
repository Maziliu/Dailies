import 'package:dailies/common/enums/parse_stage.dart';
import 'package:dailies/common/utils/build_context_extensions.dart';
import 'package:dailies/common/utils/ui_helpers.dart';
import 'package:dailies/service/parsing/parse_progress.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/upload/components/circular_progress_bar.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/file_upload_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileWidget extends StatelessWidget {
  final PlatformFile _file;
  final ParseProgress? _progress;
  final FileUploadViewModel _fileUploadViewModel;

  const FileWidget({
    super.key,
    required PlatformFile file,
    required FileUploadViewModel fileUploadViewModel,
    ParseProgress? progress,
  }) : _file = file,
       _fileUploadViewModel = fileUploadViewModel,
       _progress = progress;

  bool _showRemoveFileButton(ParseProgress? progress) =>
      progress == null || progress.currentStage == ParseStage.ERROR;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black26,
      elevation: 0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.fromLTRB(12, 8, 8, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: _buildFileTypeIcon(_file),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _file.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: context.textTheme.headlineMedium,
                            ),
                            Text(
                              'Size: ${formatFileSize(_file.size)}',
                              style: context.textTheme.bodyMedium,
                            ),

                            if (_progress?.statusMessage != null)
                              Text(
                                _progress!.statusMessage!,
                                style: context.textTheme.bodyMedium,
                              ),

                            if (_progress?.errorMessage != null)
                              Text(
                                _progress!.errorMessage!,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_progress != null)
                      Padding(
                        padding: const EdgeInsetsGeometry.only(left: 8),
                        child: _buildStatusIcon(
                          _progress.currentStage,
                          _progress,
                        ),
                      ),
                    UIFormating.smallHorizontalSpacing(),
                    if (_showRemoveFileButton(_progress))
                      IconButton(
                        onPressed:
                            () =>
                                _fileUploadViewModel.removeUploadedFile(_file),
                        icon: const Icon(Icons.close),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(ParseStage stage, ParseProgress? progress) {
    switch (stage) {
      case ParseStage.PENDING:
        return const Icon(Icons.schedule, color: Colors.grey, size: 20);
      case ParseStage.STRIPPING:
      case ParseStage.LLM_PROCESSING:
      case ParseStage.ICS_PARSING:
        return SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressBar(
            progressIndicator: CircularProgressIndicator(
              value: progress?.overallProgress,
              strokeWidth: 2,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        );
      case ParseStage.COMPLETED:
        return const Icon(Icons.check_circle, color: Colors.green, size: 20);
      case ParseStage.ERROR:
        return const Icon(Icons.error, color: Colors.red, size: 20);
    }
  }

  Widget _buildFileTypeIcon(PlatformFile file) {
    switch (file.extension) {
      case 'pdf':
        return const Icon(Icons.picture_as_pdf, color: Colors.red, size: 30);
      case 'ics':
        return const Icon(Icons.calendar_today, color: Colors.grey, size: 30);
      default:
        return const Icon(Icons.file_copy, color: Colors.grey, size: 30);
    }
  }
}
