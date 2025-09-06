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
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.black26,
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsetsGeometry.fromLTRB(12, 8, 8, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(files[index].name, style: const TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 1),
                                  Text('Size: ${_formatFileSize(files[index].size)}'),
                                ],
                              ),
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
                if (files.isNotEmpty) UIFormating.mediumVerticalSpacing(),
                if (files.isNotEmpty) Center(child: ElevatedButton(onPressed: _fileUploadViewModel.parseAllUploadedFiles, child: const Text('Parse Files'))),
              ],
            );
          },
          child: TextButton(
            onPressed: () {
              _fileUploadViewModel.uploadedFiles.value = [];
            },
            child: const Text('Clear'),
          ),
        ),
      ],
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
