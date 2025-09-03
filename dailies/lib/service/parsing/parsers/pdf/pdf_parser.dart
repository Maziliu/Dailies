import 'dart:io';

import 'package:dailies/common/utils/result.dart';
import 'package:dailies/common/utils/result_helpers.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/service/parsing/mixin/llm_prompter_mixin.dart';
import 'package:dailies/service/parsing/mixin/text_chunker_mixin.dart';
import 'package:dailies/service/parsing/parsers/ics/ics_parser.dart';
import 'package:dailies/service/parsing/parsers/parser.dart';
import 'package:file_picker/file_picker.dart' show PlatformFile;
import 'package:icalendar_parser/icalendar_parser.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PDFParser extends Parser with TextChunkerMixin, LLMPrompterMixin {
  @override
  Future<Result<List<Event>>> parseFile(String? filePath) async {
    if (filePath == null) return Result.error(Exception("PDF file path is null"));

    File pdfFile = File(filePath);
    if (!(await pdfFile.exists())) {
      return Result.error(Exception("PDF file does not exist $filePath"));
    }

    PdfDocument document = PdfDocument(inputBytes: await pdfFile.readAsBytes());
    PdfTextExtractor extractor = PdfTextExtractor(document);

    final List<String> chunks = chunkText(extractor.extractTextLines().map((line) => line.text).join('\n'));

    document.dispose();

    Result<String> llmResult = await promptLLM(chunks.join('\n'));

    if (llmResult is Error) return Result.error((llmResult as Error).error);

    Result<ICalendar> iCalendarResult = gaurdedExectute(() => ICalendar.fromString((llmResult as Ok).value));
    if (iCalendarResult is Error) return Result.error((iCalendarResult as Error).error);

    return ICSParser.parseICalendar(ICalendar.fromString((llmResult as Ok).value));
  }
}
