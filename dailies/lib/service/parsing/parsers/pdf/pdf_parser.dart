import 'dart:io';

import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/service/parsing/parsers/parser.dart';
import 'package:file_picker/file_picker.dart' show PlatformFile;
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PDFParser extends Parser {
  @override
  Future<Result<List<Event>>> parseFile(PlatformFile file) async {
    if (file.path == null) return Result.error(Exception("PDF file path is null"));

    File pdfFile = File(file.path!);
    if (!(await pdfFile.exists())) {
      return Result.error(Exception("PDF file does not exist ${file.path}"));
    }

    PdfDocument document = PdfDocument(inputBytes: await pdfFile.readAsBytes());
    PdfTextExtractor extractor = PdfTextExtractor(document);

    String content = _stripContent(extractor.extractText());

    final List<TextLine> lines = extractor.extractTextLines();
    final String lineContent = lines.map((l) => l.text).join("\n");

    document.dispose();

    final List<String> sentenceChunks = _extractChunks(content);
    final List<String> lineChunks = _extractChunks(lineContent, splitByLines: true);

    final List<String> chunks = {...sentenceChunks, ...lineChunks}.toList();

    for (final c in chunks) {
      print(c);
    }

    return Result.ok([]);
  }

  String _stripContent(String content) => content.replaceAll(RegExp(r'[\r\n]+'), ' ').trim(); //Remove all the large spaces

  List<String> _extractChunks(String content, {bool splitByLines = false}) {
    final parts =
        splitByLines
            ? content.split("\n") //for table rows
            : content.split(RegExp(r'(?<=[.!?])\s+'));

    final sentences = parts.map((s) => s.trim()).where((s) => s.isNotEmpty).toList();

    List<String> chunks = [];
    for (int i = 0; i < sentences.length; i++) {
      if (_isRelevantSentence(sentences[i])) {
        final before = (i > 0 && !splitByLines) ? sentences[i - 1] : '';
        final after = (i < sentences.length - 1 && !splitByLines) ? sentences[i + 1] : '';
        final chunk = [before, sentences[i], after].where((s) => s.isNotEmpty).join(' ');

        if (_isRelevantChunk(chunk)) chunks.add(chunk);
      }
    }
    return chunks;
  }

  bool _isRelevantSentence(String sentence) {
    final RegExp dateRegex = RegExp(
      r'(\b\d{1,2}[/-]\d{1,2}[/-]\d{2,4}\b|' //ex: 01/09/2025
      r'\b\d{4}[/-]\d{1,2}[/-]\d{1,2}\b|' //ex: 2025-09-01
      r'\b(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Sept|Oct|Nov|Dec)[a-z]*\s+\d{1,2},?\s+\d{2,4}\b|' //ex: Sep 1, 2025
      r'\b\d{1,2}\s+(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Sept|Oct|Nov|Dec)[a-z]*\s+\d{2,4}\b)', //ex: 1 September 2025
      caseSensitive: false,
    );
    if (dateRegex.hasMatch(sentence)) return true;

    final timeRegExp = RegExp(r'(0?[1-9]|1[0-2]):([0-5][0-9])\s?(am|pm)', caseSensitive: false);
    if (timeRegExp.hasMatch(sentence)) return true;

    return false;
  }

  bool _isRelevantChunk(String chunk) {
    //page numbers, headers, or footers
    if (RegExp(r'^\d{4}-\d{2}-\d{2}\s+\d+\s+of\s*\d*$').hasMatch(chunk.trim())) return false; //ex: "2024-08-29 1 of 9"

    //Remove chunks that are just "Electronically Approved" stamps
    if (RegExp(r'electronically\s+approved', caseSensitive: false).hasMatch(chunk)) return false;

    final eventKeywords = RegExp(
          r'(due|deadline|exam|test|assignment|lab|class|lecture|meeting|event|schedule|submit|quiz|project|presentation|workshop|seminar|conference|report)',
          caseSensitive: false,
        ),
        timeKeywords = RegExp(r'(at\s+\d{1,2}:\d{2}|pm|am|\d+\s+minutes?|hours?)', caseSensitive: false);

    if (eventKeywords.hasMatch(chunk) || timeKeywords.hasMatch(chunk)) return true;

    if (RegExp(r'(week|assignment|lab)\s+\d+', caseSensitive: false).hasMatch(chunk)) return true; //Prob structuered data like tables and shcedules

    final RegExp dateRegex = RegExp(
      r'(\b\d{1,2}[/-]\d{1,2}[/-]\d{2,4}\b|' //ex: 01/09/2025
      r'\b\d{4}[/-]\d{1,2}[/-]\d{1,2}\b|' //ex: 2025-09-01
      r'\b(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Sept|Oct|Nov|Dec)[a-z]*\s+\d{1,2},?\s+\d{2,4}\b|' //ex: Sep 1, 2025
      r'\b\d{1,2}\s+(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Sept|Oct|Nov|Dec)[a-z]*\s+\d{2,4}\b)', //ex: 1 September 2025
      caseSensitive: false,
    );
    final dateMatches = dateRegex.allMatches(chunk);
    if (dateMatches.length > 1) return true; //Multi dates

    return false;
  }
}
