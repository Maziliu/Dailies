import 'package:dailies/common/exceptions/llm_exceptions.dart';
import 'package:dailies/common/utils/result.dart';
import 'package:dailies/service/llm/llm_service.dart';

mixin LLMPrompterMixin {
  final String _mainModel = 'deepseek/deepseek-chat-v3.1:free';
  final List<String> _fallBackModels = ['meta-llama/llama-3.3-8b-instruct:free', 'mistralai/mistral-small-3.2-24b-instruct:free'];

  Future<Result<String>> promptLLM(String content) async {
    final List<String> models = [_mainModel, ..._fallBackModels];

    for (final String model in models) {
      final Result<String> result = await LLMService.prompt(model: model, content: content);

      switch (result) {
        case Ok<String>():
          return result;
        case Error<String>(error: final error):
          if (error is NoAPIKeyException || error is InsufficientCreditsException || error is RateLimitedException) return result;
      }
    }

    return Result.error(Exception('All models failed'));
  }
}
