import 'package:dailies/ui/mixins/error_stream_mixin.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileUploadViewModel extends ChangeNotifier with ErrorStreamMixin {
  final ValueNotifier<List<PlatformFile>> uploadedFiles = ValueNotifier<List<PlatformFile>>([]);

  late final Future<void> Function(List<PlatformFile>) parseFilesCallback;

  Future<void> parseAllUploadedFiles() async {
    await parseFilesCallback(uploadedFiles.value);
  }
}
