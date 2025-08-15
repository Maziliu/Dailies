import 'dart:io';

import 'package:dailies/ui/mixins/service_view_model_mixin.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileUploadViewModel extends ChangeNotifier with ServiceViewModelMixin {
  ValueNotifier<List<PlatformFile>> uploadedFiles = ValueNotifier<List<PlatformFile>>([]);

  Future<void> parseAllUploadedFiles() async {}
}
