import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/service/parsing/file_parser_service.dart';
import 'package:dailies/service/parsing/parse_progress.dart';
import 'package:dailies/ui/mixins/error_stream_mixin.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/file_upload_view_model.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/sub%20page/sections/configuration_section_view_model.dart';
import 'package:dailies/ui/views/upload/parsed%20events%20section/parsed_events_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class UploadViewModel extends ChangeNotifier with ErrorStreamMixin {
  final FileUploadViewModel _fileUploadViewModel;
  final ParsedEventsViewModel _parsedEventsViewModel;
  final ConfigurationSectionViewModel _configurationSectionViewModel;

  UploadViewModel({
    required FileUploadViewModel fileUploadViewModel,
    required ParsedEventsViewModel parsedEventsViewModel,
    required ConfigurationSectionViewModel configurationSectionViewModel,
  }) : _fileUploadViewModel = fileUploadViewModel,
       _parsedEventsViewModel = parsedEventsViewModel,
       _configurationSectionViewModel = configurationSectionViewModel {
    _fileUploadViewModel.parseFilesCallback = _parseFiles;
  }

  FileUploadViewModel get fileUploadViewModel => _fileUploadViewModel;
  ParsedEventsViewModel get parsedEventsViewModel => _parsedEventsViewModel;
  ConfigurationSectionViewModel get configurationSectionViewModel =>
      _configurationSectionViewModel;

  Future<void> _parseFiles(
    List<PlatformFile> files,
    Function(String, ParseProgress) onProgress,
  ) async {
    print(_configurationSectionViewModel.configurations);
    final results = await _backgroundParseFiles(
      files,
      onProgress,
      _configurationSectionViewModel.configurations,
    );

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

    _configurationSectionViewModel.clearConfigurations();
  }
}

Future<List<Result<List<Event>>>> _backgroundParseFiles(
  List<PlatformFile> files,
  Function(String, ParseProgress) onProgress,
  Map<String, Map<String, dynamic>> configurations,
) async =>
    await FileParserService().parseFiles(files, configurations, onProgress);
