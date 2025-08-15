import 'package:dailies/ui/mixins/page_view_model_mixin.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/file_upload_view_model.dart';
import 'package:flutter/material.dart';

class UploadViewModel extends ChangeNotifier with PageViewModelMixin {
  final FileUploadViewModel _fileUploadViewModel;

  UploadViewModel({required FileUploadViewModel fileUploadViewModel}) : _fileUploadViewModel = fileUploadViewModel;

  FileUploadViewModel get fileUploadViewModel => _fileUploadViewModel;
}
