import 'package:dailies/common/app_constants.dart';
import 'package:dailies/common/enums/parse_stage.dart';
import 'package:dailies/service/parsing/file_parser_service.dart';
import 'package:dailies/service/parsing/parse_progress.dart';
import 'package:dailies/service/parsing/parsers/parser.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/file_upload_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileUploadSection extends StatelessWidget {
  final FileUploadViewModel _fileUploadViewModel;

  const FileUploadSection({super.key, required FileUploadViewModel fileUploadViewModel}) : _fileUploadViewModel = fileUploadViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: UIFormating.mediumPadding(),
          child: InkWell(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color.fromRGBO(158, 158, 158, 0.5)),
                color: Colors.transparent,
              ),
              child: Padding(
                padding: UIFormating.extraLargePadding(),
                child: const Column(children: [Icon(Icons.file_upload_outlined, color: Colors.grey), Text('Upload Files')]),
              ),
            ),
            onTap: () async {
              final picked = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.custom, allowedExtensions: ['ics', 'pdf']);

              if (picked != null) _fileUploadViewModel.uploadedFiles.value = picked.files;
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: _fileUploadViewModel.uploadedFiles,
          builder: (context, files, clearButton) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('   Files (${files.length})'), if (clearButton != null) clearButton]),

                StreamBuilder<Map<String, ParseProgress>>(
                  stream: _fileUploadViewModel.progressStream,
                  builder: (context, progressSnapshot) {
                    final progressMap = progressSnapshot.data ?? {};

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final PlatformFile file = files[index];
                        final ParseProgress? progress = progressMap[file.name];

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
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(file.name, style: const TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 1),
                                          Text('Size: ${_formatFileSize(file.size)}'),

                                          if (progress?.statusMessage != null)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4),
                                              child: Text(progress!.statusMessage!, style: TextStyle(fontSize: 12, color: Colors.grey[400])),
                                            ),

                                          if (progress?.errorMessage != null)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4),
                                              child: Text(progress!.errorMessage!, style: const TextStyle(fontSize: 12, color: Colors.red)),
                                            ),
                                        ],
                                      ),
                                    ),

                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _buildStatusIcon(progress?.currentStage),
                                        UIFormating.smallHorizontalSpacing(),

                                        if (progress?.currentStage != ParseStage.STRIPPING &&
                                            progress?.currentStage != ParseStage.LLM_PROCESSING &&
                                            progress?.currentStage != ParseStage.ICS_PARSING)
                                          IconButton(onPressed: () => _fileUploadViewModel.removeUploadedFile(file), icon: const Icon(Icons.close)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              if (progress != null &&
                                  (progress.currentStage == ParseStage.STRIPPING ||
                                      progress.currentStage == ParseStage.LLM_PROCESSING ||
                                      progress.currentStage == ParseStage.ICS_PARSING ||
                                      progress.currentStage == ParseStage.COMPLETED))
                                _buildProgressBar(progress),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),

                if (files.isNotEmpty) UIFormating.mediumVerticalSpacing(),
                if (files.isNotEmpty) Center(child: ElevatedButton(onPressed: _fileUploadViewModel.parseAllUploadedFiles, child: const Text('Parse Files'))),
              ],
            );
          },
          child: TextButton(onPressed: _fileUploadViewModel.clearUploadedFiles, child: const Text('Clear')),
        ),
      ],
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} kB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  Widget _buildProgressBar(ParseProgress progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: LinearProgressIndicator(
        value: progress.overallProgress,
        backgroundColor: Colors.grey[700],
        valueColor: AlwaysStoppedAnimation<Color>(progress.currentStage == ParseStage.ERROR ? Colors.red : Colors.blue),
      ),
    );
  }

  Widget _buildStatusIcon(ParseStage? stage) {
    switch (stage) {
      case ParseStage.PENDING:
        return const Icon(Icons.schedule, color: Colors.grey, size: 20);
      case ParseStage.STRIPPING:
      case ParseStage.LLM_PROCESSING:
      case ParseStage.ICS_PARSING:
        return const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)));
      case ParseStage.COMPLETED:
        return const Icon(Icons.check_circle, color: Colors.green, size: 20);
      case ParseStage.ERROR:
        return const Icon(Icons.error, color: Colors.red, size: 20);
      default:
        return const SizedBox(width: 20, height: 20);
    }
  }
}
