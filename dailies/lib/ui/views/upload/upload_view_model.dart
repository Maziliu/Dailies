import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/service/parsers/file_parser_service.dart';
import 'package:dailies/ui/mixins/error_stream_mixin.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/file_upload_view_model.dart';
import 'package:dailies/ui/views/upload/parsed%20events%20section/parsed_events_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class UploadViewModel extends ChangeNotifier with ErrorStreamMixin {
  final FileParserService _fileParserService;
  final FileUploadViewModel _fileUploadViewModel;
  final ParsedEventsViewModel _parsedEventsViewModel;

  UploadViewModel({
    required FileParserService fileParserService,
    required FileUploadViewModel fileUploadViewModel,
    required ParsedEventsViewModel parsedEventsViewModel,
  }) : _fileParserService = fileParserService,
       _fileUploadViewModel = fileUploadViewModel,
       _parsedEventsViewModel = parsedEventsViewModel {
    _fileUploadViewModel.parseFilesCallback = _parseFiles;
  }

  FileUploadViewModel get fileUploadViewModel => _fileUploadViewModel;
  ParsedEventsViewModel get parsedEventsViewModel => _parsedEventsViewModel;

  Future<void> _parseFiles(List<PlatformFile> files) async {
    final results = await compute(_backgroundParseFiles, {'service': _fileParserService, 'files': files});

    final List<Event> events = [
      for (final Result result in results)
        if (result is Ok<List<Event>>) ...result.value,
    ];

    final List<Exception> errors = [
      for (final Result result in results)
        if (result is Error) result.error,
    ];

    _parsedEventsViewModel.foundEvents.value = events;

    for (final Exception error in errors) {
      emitError(error);
    }
  }
}

Future<List<Result<List<Event>>>> _backgroundParseFiles(Map<String, dynamic> params) async {
  final FileParserService service = params['service'];
  final List<PlatformFile> files = params['files'];
  return await service.parseFiles(files);
}
