import 'dart:convert';
import 'dart:io';

import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/models/event.dart';
import 'package:file_picker/file_picker.dart';

abstract class Parser {
  Future<Result<List<Event>>> parseFile(String? filePath);
}
