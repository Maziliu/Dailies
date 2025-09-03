import 'dart:convert';

import 'package:dailies/common/utils/result.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class LLMService {
  static Future<Result<String>> prompt({required String model, required String content, String? additionalInstructions}) async {
    await dotenv.load(fileName: '.env');

    final String? openRouterApiKey = dotenv.env['OPEN_ROUTER_API_KEY'];

    if (openRouterApiKey == null) return Result.error(Exception('No API key'));

    final url = Uri.parse("https://openrouter.ai/api/v1");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json", "Authorization": "Bearer $openRouterApiKey"},
      body: jsonEncode({
        "model": model,
        "messages": [
          {
            "role": "system",
            "content": "You are a parser for a calendar app. Given a block of text, extract all deadlines, assignments, events, etc. Respond in ics format",
          },
          {"role": "user", "content": content},
        ],
      }),
    );

    if (response.statusCode == 200) {
      final Map data = jsonDecode(response.body);
      return Result.ok(data['choices'][0]["message"]["content"]);
    } else {
      return Result.error(Exception('Failed ${response.statusCode} ${response.body}'));
    }
  }
}
