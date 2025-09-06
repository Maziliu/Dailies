import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/models/event.dart';

abstract class Parser {
  Future<Result<List<Event>>> parseFile(String? filePath);
}
