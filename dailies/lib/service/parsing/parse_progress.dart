import 'package:dailies/common/enums/parse_stage.dart';

class ParseProgress {
  final ParseStage currentStage;
  final double stageProgress;
  final double overallProgress;
  final String? statusMessage;
  final String? errorMessage;

  ParseProgress({
    required this.currentStage,
    this.stageProgress = 0.0,
    this.overallProgress = 0.0,
    this.statusMessage,
    this.errorMessage,
  });
}
