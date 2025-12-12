import 'dart:async';

import 'package:dailies/common/enums/parse_stage.dart';
import 'package:dailies/common/exceptions/parser_exceptions.dart';
import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/service/parsing/parse_progress.dart';
import 'package:dailies/service/parsing/parsers/ics/ics_parser.dart';
import 'package:dailies/service/parsing/parsers/parser.dart';
import 'package:dailies/service/parsing/parsers/pdf/pdf_parser.dart';
import 'package:file_picker/file_picker.dart';

class FileParserService {
  Parser? _fileParser;

  Future<List<Result<List<Event>>>> parseFiles(
    List<PlatformFile> files,
    Map<String, Map<String, dynamic>> configurations,
    Function(String fileName, ParseProgress progress)? onProgress,
  ) async {
    final List<Result<List<Event>>> results = [];

    for (final PlatformFile file in files) {
      _determineFileParser(file);

      if (_fileParser == null) {
        onProgress?.call(
          file.name,
          ParseProgress(
            currentStage: ParseStage.ERROR,
            errorMessage: 'Unsupported file type: ${file.extension}',
          ),
        );
        results.add(
          Result.error(UnableToParseException(specificFile: file.toString())),
        );
        continue;
      }

      onProgress?.call(
        file.name,
        ParseProgress(
          currentStage: ParseStage.PENDING,
          statusMessage: 'Starting parse...',
        ),
      );

      final result = await _fileParser!.parseFile(
        configurations.containsKey(file.name)
            ? configurations[file.name]
            : null,
        file.path,
        onProgress: (stage, progress, message) {
          onProgress?.call(
            file.name,
            ParseProgress(
              currentStage: stage,
              stageProgress: progress,
              overallProgress: _calculateOverallProgress(
                file.extension,
                stage,
                progress,
              ),
              statusMessage: message,
            ),
          );
        },
      );

      switch (result) {
        case Ok<List<Event>>():
          onProgress?.call(
            file.name,
            ParseProgress(
              currentStage: ParseStage.COMPLETED,
              stageProgress: 1.0,
              overallProgress: 1.0,
              statusMessage: 'Completed!',
            ),
          );
        case Error<List<Event>>(error: final error):
          onProgress?.call(
            file.name,
            ParseProgress(
              currentStage: ParseStage.ERROR,
              errorMessage: error.toString(),
            ),
          );
      }

      results.add(result);
    }

    return results;
  }

  double _calculateOverallProgress(
    String? extension,
    ParseStage currentStage,
    double stageProgress,
  ) {
    List<ParseStage> stages;

    switch (extension) {
      case 'ics':
        stages = [ParseStage.ICS_PARSING];
      case 'pdf':
        stages = [
          ParseStage.STRIPPING,
          ParseStage.LLM_PROCESSING,
          ParseStage.ICS_PARSING,
        ];
      default:
        return 0.0;
    }

    final int currentIndex = stages.indexOf(currentStage);
    if (currentIndex == -1) return 0.0;

    final double stageWeight = 1.0 / stages.length;
    return (currentIndex * stageWeight) + (stageProgress * stageWeight);
  }

  void _determineFileParser(PlatformFile file) {
    switch (file.extension) {
      case 'ics':
        _fileParser = ICSParser();
      case 'pdf':
        _fileParser = PDFParser();
      default:
        _fileParser = null;
    }
  }
}
