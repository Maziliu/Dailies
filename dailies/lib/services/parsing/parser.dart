import 'dart:convert';
import 'dart:io';

import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/utils/result.dart';
import 'package:file_picker/file_picker.dart';

abstract class FileParser {
  Future<Result<String>> extractTextFromFile(PlatformFile file) async {
    if (file.bytes != null) {
      return Result.ok(utf8.decode(file.bytes!));
    }

    if (file.path != null) {
      final f = File(file.path!);
      return Result.ok(await f.readAsString());
    }

    return Result.error(
      FileExtractionFailure('Failed to extract file ${file.name}'),
    );
  }

  Future<Result<List<Result<EventInfoModel>>>> rawTextToEventInfos(
    String rawText,
  );

  Stream<FileParseEvent> parseFilesStream(List<PlatformFile> files);
}

sealed class FileParseEvent {}

class FileParseSuccess extends FileParseEvent {
  final EventInfoModel event;
  FileParseSuccess(this.event);
}

class FileParseFailure extends FileParseEvent {
  final String fileName;
  final Failure failure;

  FileParseFailure(this.fileName, this.failure);
}

class FileParseProgress extends FileParseEvent {
  final int completed;
  final int total;

  FileParseProgress(this.completed, this.total);
}
