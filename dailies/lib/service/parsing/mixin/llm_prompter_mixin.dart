import 'package:dailies/common/utils/result.dart';
import 'package:dailies/service/llm/llm_service.dart';

mixin LLMPrompterMixin {
  final String _mainModel = 'deepseek/deepseek-chat-v3.1:free';
  final List<String> _fallBackModels = ['meta-llama/llama-3.3-8b-instruct:free', 'mistralai/mistral-small-3.2-24b-instruct:free'];

  Future<Result<String>> promptLLM(String content) async {
    final List<String> models = [_mainModel, ..._fallBackModels];

    for (final String model in models) {
      final Result<String> result = await LLMService.prompt(model: model, content: content);

      if (result is Ok) return result;
    }

    return Result.error(Exception('All models failed'));
  }
}
