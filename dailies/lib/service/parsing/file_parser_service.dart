import 'package:dailies/common/exceptions/parser_exceptions.dart';
import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/service/parsing/parsers/ics/ics_parser.dart';
import 'package:dailies/service/parsing/parsers/parser.dart';
import 'package:dailies/service/parsing/parsers/pdf/pdf_parser.dart';
import 'package:file_picker/file_picker.dart';

class FileParserService {
  Parser? _fileParser;

  Future<List<Result<List<Event>>>> parseFiles(List<PlatformFile> files) async {
    List<Result<List<Event>>> results = [];

    for (PlatformFile file in files) {
      _determineFileParser(file);

      if (_fileParser == null) {
        results.add(Result.error(UnableToParseException(specificFile: file.toString())));
        continue;
      }

      results.add(await _fileParser!.parseFile(file));
    }

    return results;
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
