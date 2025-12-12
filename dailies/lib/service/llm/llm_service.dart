import 'dart:convert';

import 'package:dailies/common/exceptions/llm_exceptions.dart';
import 'package:dailies/common/utils/result.dart';
import 'package:dailies/common/utils/result_helpers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class LLMService {
  static Future<Result<String>> prompt({
    required String model,
    required String content,
    String? additionalInstructions,
  }) async => guardedAsyncExcecute(() async {
    await dotenv.load();

    final String? openRouterApiKey = dotenv.env['OPEN_ROUTER_API_KEY'];

    if (openRouterApiKey == null) throw NoAPIKeyException();

    final url = Uri.parse('https://openrouter.ai/api/v1/chat/completions');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openRouterApiKey',
      },
      body: jsonEncode({
        'model': model,
        'messages': [
          {
            'role': 'system',
            'content': '''
                  You are a parser for a calendar app. 
                  Given a block of text, extract all deadlines, assignments, events, quizzes, exams. 
                  Respond only in valid ICS (iCalendar) format.

                  Rules:
                  - Do not use VALUE=DATE.
                  - Set DTSTAMP to the date/time of the actual event in YYYYMMDDTHHMMSSZ format.
                  - Deadlines: include only DTEND (set to same value as DTSTAMP), omit DTSTART. if no time is given assume 11:59 pm
                  - Intervals (events with a start and end): include both DTSTART and DTEND, where DTSTAMP matches the event start time.
                  - Undefined (no specific date or time): set DTSTAMP to current date and omit both DTSTART and DTEND.
                  - Always include SUMMARY and DESCRIPTION.
                  - Always begin with BEGIN:VCALENDAR / VERSION:2.0 / PRODID and end with END:VCALENDAR.
                  - Each VEVENT must begin with BEGIN:VEVENT and end with END:VEVENT.

                  Today is ${DateTime.now().toUtc()}.
        ''',
          },
          {'role': 'user', 'content': '$additionalInstructions. $content'},
        ],
        'extra': {'reasoning': false},
      }),
    );

    switch (response.statusCode) {
      case 200:
        final Map data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      case 402:
        throw InsufficientCreditsException();
      case 403:
        throw ModeratedContentException(response.body);
      case 429:
        throw RateLimitedException();
      default:
        throw Exception('Failed ${response.statusCode} ${response.body}');
    }
  });
}
