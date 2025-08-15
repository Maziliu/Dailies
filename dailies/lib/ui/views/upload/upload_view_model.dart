import 'package:dailies/ui/mixins/page_view_model_mixin.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/file_upload_view_model.dart';
import 'package:dailies/ui/views/upload/parsed%20events%20section/parsed_events_view_model.dart';
import 'package:flutter/material.dart';

class UploadViewModel extends ChangeNotifier with PageViewModelMixin {
  final FileUploadViewModel _fileUploadViewModel;
  final ParsedEventsViewModel _parsedEventsViewModel;

  UploadViewModel({required FileUploadViewModel fileUploadViewModel, required ParsedEventsViewModel parsedEventsViewModel})
    : _fileUploadViewModel = fileUploadViewModel,
      _parsedEventsViewModel = parsedEventsViewModel;

  FileUploadViewModel get fileUploadViewModel => _fileUploadViewModel;
  ParsedEventsViewModel get parsedEventsViewModel => _parsedEventsViewModel;
}
