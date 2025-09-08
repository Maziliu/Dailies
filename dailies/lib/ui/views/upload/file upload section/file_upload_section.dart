import 'package:dailies/common/utils/build_context_extensions.dart';
import 'package:dailies/service/parsing/parse_progress.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/upload/components/file_widget.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/file_upload_view_model.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/sub%20page/configure_sub_page.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/sub%20page/sections/configuration_section_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileUploadSection extends StatelessWidget {
  final FileUploadViewModel _fileUploadViewModel;
  final ConfigurationSectionViewModel _configurationSectionViewModel;

  const FileUploadSection({super.key, required FileUploadViewModel fileUploadViewModel, required ConfigurationSectionViewModel configurationSectionViewModel})
    : _fileUploadViewModel = fileUploadViewModel,
      _configurationSectionViewModel = configurationSectionViewModel;

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
                child: Column(
                  children: [
                    const Icon(Icons.file_upload_outlined, color: Colors.grey),
                    Text('Upload Files', style: context.textTheme.headlineMedium?.copyWith(color: Colors.grey[400])),
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

                if (files.isNotEmpty) _buildActionButtons(_fileUploadViewModel.requiresLLMParsing, context),
              ],
            );
          },
          child: TextButton(onPressed: _fileUploadViewModel.clearUploadedFiles, child: const Text('Clear')),
        ),
      ],
    );
  }

  Widget _buildActionButtons(bool showEditButton, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Center(
        child: Column(
          children: [
            UIFormating.mediumVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (showEditButton)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _configurationSectionViewModel.clearConfigurations();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ConfigureSubPage(
                                  viewModel: _configurationSectionViewModel,
                                  files:
                                      _fileUploadViewModel.uploadedFiles.value
                                          .where((PlatformFile file) => LLM_REQUIRED_FILE_EXTENSIONS.contains(file.extension))
                                          .toList(),
                                ),
                          ),
                        );
                      },
                      child: const Text('Configure'),
                    ),
                  ),
                if (showEditButton) UIFormating.smallHorizontalSpacing(),
                Expanded(child: ElevatedButton(onPressed: _fileUploadViewModel.parseAllUploadedFiles, child: const Text('Parse'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
