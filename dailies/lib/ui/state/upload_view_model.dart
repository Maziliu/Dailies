import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/services/parsing/ics_parser.dart';
import 'package:dailies_v2/services/parsing/parser.dart';
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

  final ValueNotifier<List<EventUIModel>> parsedEvents =
      ValueNotifier<List<EventUIModel>>([]);

  Future<void> parseAllUploadedFiles() async {
    parsedEvents.value = [];

    await for (final event in ICS_PARSER.parseFilesStream(
      uploadedFiles.value,
    )) {
      switch (event) {
        case FileParseSuccess(event: final value):
          parsedEvents.value = [
            ...parsedEvents.value,
            EventUIModel.fromEventInfo(info: value),
          ];

        case FileParseFailure():
        case FileParseProgress():
      }
    }
  }

  void clearUploadedFiles() => uploadedFiles.value = [];
  void clearParsedEvents() => parsedEvents.value = [];

  void removeUploadedFile(PlatformFile fileToRemove) {
    final newList = uploadedFiles.value
        .where((file) => file != fileToRemove)
        .toList();

    uploadedFiles.value = newList;
  }

  bool get requiresLLMParsing => uploadedFiles.value.any(
    (PlatformFile file) =>
        LLM_REQUIRED_FILE_EXTENSIONS.contains(file.extension),
  );
}
