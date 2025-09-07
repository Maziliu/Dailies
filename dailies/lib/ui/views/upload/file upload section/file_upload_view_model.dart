import 'dart:async';

import 'package:dailies/service/parsing/parse_progress.dart';
import 'package:dailies/ui/mixins/error_stream_mixin.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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
    uploadedFiles.value = uploadedFiles.value.where((PlatformFile file) => file != fileToRemove).toList();
    _parseProgress.remove(fileToRemove.name);
    _progressController.add(Map.from(_parseProgress));
  }

  @override
  void dispose() {
    _progressController.close();
    super.dispose();
  }
}
