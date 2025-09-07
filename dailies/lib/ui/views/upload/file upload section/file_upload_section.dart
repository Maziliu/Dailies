import 'package:dailies/common/app_constants.dart';
import 'package:dailies/common/enums/parse_stage.dart';
import 'package:dailies/service/parsing/file_parser_service.dart';
import 'package:dailies/service/parsing/parse_progress.dart';
import 'package:dailies/service/parsing/parsers/parser.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/upload/components/file_widget.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/file_upload_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

const List<String> SUPPORTED_FILE_EXTENSIONS = ['ics', 'pdf'];

class FileUploadSection extends StatelessWidget {
  final FileUploadViewModel _fileUploadViewModel;

  const FileUploadSection({super.key, required FileUploadViewModel fileUploadViewModel}) : _fileUploadViewModel = fileUploadViewModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

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
                child: Column(
                  children: [
                    const Icon(Icons.file_upload_outlined, color: Colors.grey),
                    Text('Upload Files', style: textTheme.headlineMedium?.copyWith(color: Colors.grey[400])),
                  ],
                ),
              ),
            ),
            onTap: () async {
              final picked = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.custom, allowedExtensions: SUPPORTED_FILE_EXTENSIONS);

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

                        return FileWidget(file: file, fileUploadViewModel: _fileUploadViewModel, progress: progress);
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
}
