import 'dart:io';

import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/service/parsing/mixin/text_chunker_mixin.dart';
import 'package:dailies/service/parsing/parsers/parser.dart';
import 'package:file_picker/file_picker.dart' show PlatformFile;
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PDFParser extends Parser with TextChunkerMixin {
  @override
  Future<Result<List<Event>>> parseFile(PlatformFile file) async {
    if (file.path == null) return Result.error(Exception("PDF file path is null"));

    File pdfFile = File(file.path!);
    if (!(await pdfFile.exists())) {
      return Result.error(Exception("PDF file does not exist ${file.path}"));
    }

    PdfDocument document = PdfDocument(inputBytes: await pdfFile.readAsBytes());
    PdfTextExtractor extractor = PdfTextExtractor(document);

    final List<String> chunks = chunkText(extractor.extractTextLines().map((line) => line.text).join('\n'));

    for (final c in chunks) {
      print(c);
    }

    document.dispose();
    return Result.ok([]);
  }
}
