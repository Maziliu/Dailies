import 'package:dailies/common/enums/parse_stage.dart';
import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/models/event.dart';

abstract class Parser {
  Future<Result<List<Event>>> parseFile(
    Map<String, dynamic>? configuration,
    String? filePath, {
    Function(ParseStage stage, double progress, String? message)? onProgress,
  });
}
