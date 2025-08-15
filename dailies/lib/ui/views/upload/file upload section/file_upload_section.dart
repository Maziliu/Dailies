import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/file_upload_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileUploadSection extends StatelessWidget {
  final FileUploadViewModel _fileUploadViewModel;

  const FileUploadSection({super.key, required FileUploadViewModel fileUploadViewModel}) : _fileUploadViewModel = fileUploadViewModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: UIFormating.mediumPadding(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color.fromRGBO(158, 158, 158, 0.5)),
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: UIFormating.extraLargePadding(),
                  child: const Column(children: [Icon(Icons.add, color: Colors.grey), Text('Upload Files')]),
                ),
              ),
              onTap: () async {
                final results = await FilePicker.platform.pickFiles(
                  allowMultiple: true,
                  type: FileType.custom,
                  allowedExtensions: ['ics', 'pdf', 'txt', 'csv'],
                );

                if (results != null) {
                  _fileUploadViewModel.uploadedFiles.value = results.files;
                }
              },
            ),
            ValueListenableBuilder(
              valueListenable: _fileUploadViewModel.uploadedFiles,
              builder: (context, files, _) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: UIFormating.smallPadding(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(files[index].name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Size: ${_formatFileSize(files[index].size)}'),
                                ],
                              ),

                              IconButton(
                                onPressed: () {
                                  _fileUploadViewModel.uploadedFiles.value =
                                      _fileUploadViewModel.uploadedFiles.value.where((PlatformFile file) => file != files[index]).toList();
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

            ElevatedButton(onPressed: () {}, child: const Text('Parse Files')),
          ],
        ),
      ),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
