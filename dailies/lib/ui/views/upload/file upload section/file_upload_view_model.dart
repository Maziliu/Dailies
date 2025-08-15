import 'dart:io';

import 'package:dailies/ui/mixins/service_view_model_mixin.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileUploadViewModel extends ChangeNotifier with ServiceViewModelMixin {
  ValueNotifier<List<PlatformFile>> uploadedFiles = ValueNotifier<List<PlatformFile>>([]);

  void testSet(List<PlatformFile> files) async {
    for (var file in files) {
      if (file.path != null) {
        final contents = await File(file.path!).readAsString();
        print(contents);
      }
    }
  }
}
