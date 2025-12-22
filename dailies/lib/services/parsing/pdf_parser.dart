import 'dart:io';

import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/services/llm/llm_service.dart';
import 'package:dailies_v2/services/parsing/ics_parser.dart';
import 'package:dailies_v2/services/parsing/parser.dart';
import 'package:dailies_v2/utils/result.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PDFParser extends FileParser {
  @override
  Future<Result<String>> extractTextFromFile(PlatformFile file) async {
    if (file.path != null) {
      final fileObject = File(file.path!);
      final PdfDocument document = PdfDocument(
        inputBytes: fileObject.readAsBytesSync(),
      );
      final String text = PdfTextExtractor(document).extractText();

      document.dispose();

      return Result.ok(text);
    }

    return Result.error(
      FileExtractionFailure('Failed to extract file ${file.name}'),
    );
  }

  @override
  Future<Result<List<Result<EventInfoModel>>>> rawTextToEventInfos(
    String rawText,
  ) async {
    final Result<String> result = await LLMService.promptLLM(rawText);

    switch (result) {
      case Ok<String>(value: final String icsString):
        return await ICS_PARSER.rawTextToEventInfos(icsString);

      case Error<String>(failure: final Failure error):
        return Result.error(error);
    }
  }
}

final PDFParser PDF_PARSER = PDFParser();
