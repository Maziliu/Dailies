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

  bool canParse(PlatformFile file);

  Stream<FileParseEvent> parseFilesStream(List<PlatformFile> files) async* {
    int completed = 0;
    final total = files.length;

    for (final file in files) {
      if (!canParse(file)) continue;

      final textResult = await extractTextFromFile(file);

      switch (textResult) {
        case Ok<String>(value: final rawText):
          final parsed = await rawTextToEventInfos(rawText);

          switch (parsed) {
            case Ok<List<Result<EventInfoModel>>>(value: final events):
              for (final event in events) {
                switch (event) {
                  case Ok<EventInfoModel>(value: final e):
                    yield FileParseSuccess(e);
                  case Error<EventInfoModel>(failure: final f):
                    yield FileParseFailure(failure: f);
                }
              }
            case Error<List<Result<EventInfoModel>>>(failure: final f):
              yield FileParseFailure(file: file, failure: f);
          }

        case Error<String>(failure: final f):
          yield FileParseFailure(file: file, failure: f);
      }

      completed++;
      yield FileParseProgress(completed, total, file);
    }
  }
}

sealed class FileParseEvent {}

class FileParseSuccess extends FileParseEvent {
  final EventInfoModel event;
  FileParseSuccess(this.event);
}

class FileParseFailure extends FileParseEvent {
  final PlatformFile? file;
  final Failure failure;

  FileParseFailure({this.file, required this.failure});
}

class FileParseProgress extends FileParseEvent {
  final PlatformFile file;
  final int completed;
  final int total;

  FileParseProgress(this.completed, this.total, this.file);
}
