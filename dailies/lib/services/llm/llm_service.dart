import 'dart:convert';

import 'package:dailies_v2/utils/result.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

const String LLM_INSTRUCTIONS = '''
You are a strict information extraction and calendar serialization system.

Your task is to analyze the provided text and extract all calendar events explicitly described in it.

Rules:
- Extract ONLY events that are clearly and explicitly stated.
- Do NOT invent, infer, guess, or assume any missing information.
- Do NOT interpret vague intentions as events.
- Ignore opinions, commentary, examples, and unrelated content.
- If required event data is missing, omit the corresponding ICS property.

ICS requirements:
- Output MUST be valid iCalendar (ICS) format compliant with RFC 5545.
- Each event MUST be represented as a VEVENT.
- Use UTC times when possible (append "Z"), otherwise omit DTSTART/DTEND.
- Use ISO-8601-derived ICS datetime format: YYYYMMDDTHHMMSSZ.
- Do NOT include non-standard properties.
- Do NOT include alarms unless explicitly mentioned.
- Do NOT include timezone definitions unless explicitly required.
- Deadline events are events with the same dtstart and dtend

Output rules:
- Return ICS content ONLY.
- Do NOT include explanations, comments, markdown, or surrounding text.
- If no events are found, return a valid but empty ICS file:
  BEGIN:VCALENDAR
  VERSION:2.0
  PRODID:-//EventExtractor//EN
  END:VCALENDAR
''';

class LLMService {
  static Future<Result<String>> promptLLM(String rawDocumentText) async {
    final String? BACKEND_URL = dotenv.env['BACKEND_URL'];
    final String? SERVER_PASSWORD = dotenv.env['SERVER_PASSWORD'];

    if (BACKEND_URL == null) {
      return Result.error(
        EnvironmentVariableFailure('Failed to read BACKEND_URL'),
      );
    }

    if (SERVER_PASSWORD == null) {
      return Result.error(
        EnvironmentVariableFailure('Failed to read SERVER_PASSWORD'),
      );
    }

    final http.Response response = await http.post(
      Uri.parse(BACKEND_URL),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'password': SERVER_PASSWORD,
        'content': {
          'instructions': LLM_INSTRUCTIONS,
          'context': rawDocumentText,
        },
      }),
    );

    if (response.statusCode == 200) {
      return Result.ok(jsonDecode(response.body)['output']);
    }

    if (response.statusCode == 401) {
      return Result.error(UnauthorizedFailure("SERVER_PASSWORD is incorrect"));
    }

    if (response.statusCode == 503) {
      return Result.error(
        NoBackendAPIKeysFailure("The backend has run out of valid api keys"),
      );
    }

    return Result.error(GenerationFailure(jsonDecode(response.body)['error']));
  }
}
