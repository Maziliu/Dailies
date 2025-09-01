import 'dart:convert';
import 'dart:io';

import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/models/event.dart';
import 'package:file_picker/file_picker.dart';

abstract class Parser {
  Future<Result<List<Event>>> parseFile(PlatformFile file);

  Future<Result<String>> getFileContents(PlatformFile file) async {
    if (file.path == null) return Result.error(Exception("ICS file path is null"));

    File inputFile = File(file.path!);
    if (!(await inputFile.exists())) return Result.error(Exception("ICS file does not exist ${file.path}"));

    String content;
    try {
      content = await inputFile.readAsString(encoding: utf8);

      return Result.ok(content);
    } catch (exception) {
      print(exception);
      return Result.error(Exception('Failed to read file content: ${exception.toString()}'));
    }
  }
}
