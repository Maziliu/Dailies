import 'package:async/async.dart';
import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/services/event/event_service.dart';
import 'package:dailies_v2/services/parsing/ics_parser.dart';
import 'package:dailies_v2/services/parsing/parser.dart';
import 'package:dailies_v2/services/parsing/pdf_parser.dart';
import 'package:dailies_v2/utils/result.dart';
import 'package:dailies_v2/utils/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

final List<String> LLM_REQUIRED_FILE_EXTENSIONS = ['pdf'];
final List<String> SUPPORTED_FILE_EXTENSIONS = [
  'ics',
  ...LLM_REQUIRED_FILE_EXTENSIONS,
];

final List<FileParser> PARSERS = [ICS_PARSER, PDF_PARSER];

class UploadViewModel extends ChangeNotifier {
  final EventService _eventService = EventService();

  final ValueNotifier<List<PlatformFile>> uploadedFiles =
      ValueNotifier<List<PlatformFile>>([]);

  final ValueNotifier<List<EventInfoModel>> parsedEvents =
      ValueNotifier<List<EventInfoModel>>([]);

  Future<void> parseAllUploadedFiles() async {
    parsedEvents.value = [];

    final streams = PARSERS.map(
      (parser) => parser.parseFilesStream(uploadedFiles.value),
    );

    await for (final event in StreamGroup.merge(streams)) {
      switch (event) {
        case FileParseSuccess(event: final value):
          parsedEvents.value = [...parsedEvents.value, value];
          showSuccessSnackbar('Found Event: ${value.title}');

        case FileParseFailure(
          failure: final Failure failure,
          fileName: final String fileName,
        ):
          showErrorSnackbar(
            failure: failure,
            customMessage: 'Could not parse: ${fileName} ${failure.message}',
          );

        case FileParseProgress():
        // update UI
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

  void addParsedToCalendar() async {
    for (final EventInfoModel event in parsedEvents.value) {
      _eventService.insertEvent(event);
    }

    clearParsedEvents();
  }
}
