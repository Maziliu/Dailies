import 'dart:async';

import 'package:dailies/service/parsing/parse_progress.dart';
import 'package:dailies/ui/mixins/error_stream_mixin.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/sub%20page/sections/configuration_section_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

final List<String> LLM_REQUIRED_FILE_EXTENSIONS = ['pdf'];
final List<String> SUPPORTED_FILE_EXTENSIONS = ['ics', ...LLM_REQUIRED_FILE_EXTENSIONS];

class FileUploadViewModel extends ChangeNotifier with ErrorStreamMixin {
  final ValueNotifier<List<PlatformFile>> uploadedFiles = ValueNotifier<List<PlatformFile>>([]);
  final StreamController<Map<String, ParseProgress>> _progressController = StreamController<Map<String, ParseProgress>>.broadcast();

  Stream<Map<String, ParseProgress>> get progressStream => _progressController.stream;

  Map<String, ParseProgress> _parseProgress = {};
  Map<String, ParseProgress> get parseProgress => Map.unmodifiable(_parseProgress);

  late final Future<void> Function(List<PlatformFile>, Function(String, ParseProgress)) parseFilesCallback;

  Future<void> parseAllUploadedFiles() async {
    await parseFilesCallback(uploadedFiles.value, _handleProgressUpdate);
  }

  void _handleProgressUpdate(String fileName, ParseProgress progress) {
    _parseProgress[fileName] = progress;
    _progressController.add(Map.from(_parseProgress));
    notifyListeners();
  }

  ParseProgress? getProgressForFile(String fileName) {
    return _parseProgress[fileName];
  }

  void clearUploadedFiles() {
    _parseProgress = {};
    uploadedFiles.value = [];
    _progressController.add({});
  }

  void removeUploadedFile(PlatformFile fileToRemove) {
    uploadedFiles.value = uploadedFiles.value.where((file) => file != fileToRemove).toList();

    _parseProgress.remove(fileToRemove.name);
    _progressController.add(Map.from(_parseProgress));
  }

  bool get requiresLLMParsing => uploadedFiles.value.any((PlatformFile file) => LLM_REQUIRED_FILE_EXTENSIONS.contains(file.extension));

  @override
  void dispose() {
    _progressController.close();
    super.dispose();
  }
}
