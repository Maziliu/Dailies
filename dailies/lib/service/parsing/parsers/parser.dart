import 'package:dailies/common/enums/parse_stage.dart';
import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/models/event.dart';

abstract class Parser {
  Future<Result<List<Event>>> parseFile(String? filePath, {Function(ParseStage stage, double progress, String? message)? onProgress});
}
