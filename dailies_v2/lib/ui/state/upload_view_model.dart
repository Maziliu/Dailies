import 'package:dailies_v2/models/event_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

final List<String> LLM_REQUIRED_FILE_EXTENSIONS = ['pdf'];
final List<String> SUPPORTED_FILE_EXTENSIONS = [
  'ics',
  ...LLM_REQUIRED_FILE_EXTENSIONS,
];

class UploadViewModel extends ChangeNotifier {
  final ValueNotifier<List<PlatformFile>> uploadedFiles =
      ValueNotifier<List<PlatformFile>>([]);

  final ValueNotifier<List<EventModel>> parsedEvents =
      ValueNotifier<List<EventModel>>([]);

  Future<void> parseAllUploadedFiles() async {}

  void clearUploadedFiles() {}
  void clearParsedEvents() {}

  void removeUploadedFile(PlatformFile fileToRemove) {
    uploadedFiles.value = uploadedFiles.value
        .where((file) => file != fileToRemove)
        .toList();
  }

  bool get requiresLLMParsing => uploadedFiles.value.any(
    (PlatformFile file) =>
        LLM_REQUIRED_FILE_EXTENSIONS.contains(file.extension),
  );
}
