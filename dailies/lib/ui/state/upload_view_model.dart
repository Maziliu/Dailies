import 'package:async/async.dart';
import 'package:dailies_v2/enums/parse_progress.dart';
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

class PlatformFileWithProgress {
  final PlatformFile file;
  final ParseProgress? parseProgress;

  const PlatformFileWithProgress({required this.file, this.parseProgress});
}

class UploadViewModel extends ChangeNotifier {
  final EventService _eventService = EventService();

  final ValueNotifier<List<PlatformFileWithProgress>> uploadedFiles =
      ValueNotifier<List<PlatformFileWithProgress>>([]);

  final ValueNotifier<List<EventInfoModel>> parsedEvents =
      ValueNotifier<List<EventInfoModel>>([]);

  Future<Set<PlatformFile>> _parseFiles(List<PlatformFile> files) async {
    final streams = PARSERS.map((parser) => parser.parseFilesStream(files));

    final failedFiles = <PlatformFile>{};

    await for (final event in StreamGroup.merge(streams)) {
      switch (event) {
        case FileParseSuccess(event: final value):
          parsedEvents.value = [...parsedEvents.value, value];
          showSuccessSnackbar('${value.date} ${value.start} ${value.end}');

        case FileParseFailure(
          failure: final Failure failure,
          file: final PlatformFile file,
        ):
          failedFiles.add(file);
          showErrorSnackbar(
            failure: failure,
            customMessage: 'Could not parse: ${file.name} ${failure.message}',
          );

        case FileParseFailure(file: null, failure: final Failure failure):
          showErrorSnackbar(failure: failure);

        case FileParseProgress():
          break;
      }
    }

    return failedFiles;
  }

  void _setFileProgress(PlatformFile file, ParseProgress progress) {
    final index = uploadedFiles.value.indexWhere((f) => f.file == file);
    if (index == -1) return;

    final updated = [...uploadedFiles.value];
    updated[index] = PlatformFileWithProgress(
      file: file,
      parseProgress: progress,
    );
    uploadedFiles.value = updated;
  }

  Future<void> parseAllUploadedFiles() async {
    parsedEvents.value = [];

    uploadedFiles.value = uploadedFiles.value
        .map(
          (f) => PlatformFileWithProgress(
            file: f.file,
            parseProgress: ParseProgress.IN_PROGRESS,
          ),
        )
        .toList();

    final files = uploadedFiles.value.map((f) => f.file).toList();
    final failedFiles = await _parseFiles(files);

    uploadedFiles.value = uploadedFiles.value.map((f) {
      if (failedFiles.contains(f.file)) {
        return PlatformFileWithProgress(
          file: f.file,
          parseProgress: ParseProgress.FAILED,
        );
      }

      if (f.parseProgress == ParseProgress.IN_PROGRESS) {
        return PlatformFileWithProgress(
          file: f.file,
          parseProgress: ParseProgress.COMPLETED,
        );
      }

      return f;
    }).toList();
  }

  Future<void> retryParseFile(PlatformFileWithProgress target) async {
    _setFileProgress(target.file, ParseProgress.IN_PROGRESS);

    final failedFiles = await _parseFiles([target.file]);

    _setFileProgress(
      target.file,
      failedFiles.contains(target.file)
          ? ParseProgress.FAILED
          : ParseProgress.COMPLETED,
    );
  }

  void clearUploadedFiles() => uploadedFiles.value = [];
  void clearParsedEvents() => parsedEvents.value = [];

  void removeUploadedFile(PlatformFile fileToRemove) {
    uploadedFiles.value = uploadedFiles.value
        .where((f) => f.file != fileToRemove)
        .toList();
  }

  void addParsedToCalendar() async {
    for (final EventInfoModel event in parsedEvents.value) {
      _eventService.insertEvent(event);
    }

    clearParsedEvents();

    uploadedFiles.value = uploadedFiles.value
        .where((f) => f.parseProgress == ParseProgress.FAILED)
        .toList();
  }
}
