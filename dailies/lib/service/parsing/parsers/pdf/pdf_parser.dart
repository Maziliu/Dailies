import 'dart:io';

import 'package:dailies/common/enums/parse_stage.dart';
import 'package:dailies/common/utils/result.dart';
import 'package:dailies/common/utils/result_helpers.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/service/parsing/mixin/llm_prompter_mixin.dart';
import 'package:dailies/service/parsing/mixin/text_chunker_mixin.dart';
import 'package:dailies/service/parsing/parsers/ics/ics_parser.dart';
import 'package:dailies/service/parsing/parsers/parser.dart';
import 'package:icalendar_parser/icalendar_parser.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PDFParser extends Parser with TextChunkerMixin, LLMPrompterMixin {
  @override
  Future<Result<List<Event>>> parseFile(Map<String, dynamic>? configuration, String? filePath, {Function(ParseStage, double, String?)? onProgress}) async {
    if (filePath == null) return Result.error(Exception('PDF file path is null'));

    final File pdfFile = File(filePath);
    if (!pdfFile.existsSync()) {
      return Result.error(Exception('PDF file does not exist $filePath'));
    }

    String inputText;

    final PdfDocument document = PdfDocument(inputBytes: await pdfFile.readAsBytes());
    final PdfTextExtractor extractor = PdfTextExtractor(document);

    if (configuration?['allowCondense'] ?? false) {
      onProgress?.call(ParseStage.STRIPPING, 0.0, 'Chunking PDF...');

      final List<String> chunks = chunkText(extractor.extractTextLines().map((line) => line.text).join('\n'), (progress) {
        onProgress?.call(ParseStage.STRIPPING, progress, 'Extracting... ${(progress * 100).toInt()}%');
      });

      inputText = chunks.join('\n');
    } else {
      inputText = extractor.extractTextLines().map((line) => line.text).join('\n');
    }
    document.dispose();

    onProgress?.call(ParseStage.LLM_PROCESSING, 0.0, 'Processing with AI...');
    final Result<String> llmResult = await promptLLM(inputText, configuration?['instructions'] ?? '');

    if (llmResult is Error) return Result.error((llmResult as Error).error);

    onProgress?.call(ParseStage.LLM_PROCESSING, 1.0, 'Processing with AI... 100%');

    final Result<ICalendar> iCalendarResult = gaurdedExectute(() => ICalendar.fromString((llmResult as Ok).value));
    if (iCalendarResult is Error) return Result.error((iCalendarResult as Error).error);

    onProgress?.call(ParseStage.ICS_PARSING, 0.0, 'ICS Parsing...');
    return ICSParser.parseICalendar(ICalendar.fromString((llmResult as Ok).value), (double progress) {
      onProgress?.call(ParseStage.ICS_PARSING, progress, 'ICS Parsing... ${(progress * 100).toInt()}%');
    });
  }
}
