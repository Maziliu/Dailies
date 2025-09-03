import 'package:dailies/common/utils/result.dart';
import 'package:dailies/service/llm/llm_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test/test.dart';

void main() {
  test('LLMService returns ics formatted response from real API', () async {
    final Result response = await LLMService.prompt(
      model: "meta-llama/llama-3.3-8b-instruct:free",
      content:
          "Your reflection should demonstrate awareness of your responsibilities as a communicator and thoughtful engagement with digital writing tools. Oct 9 10% Proposal (Group) You will write a proposal (750-1000 words plus appendices) outlining what you aim to achieve in your formal report. Secondary and primary research will be Oct 30 necessary to complete the proposal.\n\nOnline Quiz Policy • Quizzes will be open-book and delivered asynchronously on D2L within the dates stated in the assessments table. • The quiz will become available on D2L on or before 18:00 (6:00 PM) on the availability date. An email announcement will be sent when it becomes available. • The quiz must be submitted before 18:00 (6:00 PM) on the scheduled date 48 hours after the quiz becomes available.\n\nWeek 1 Sep 2 Issues and Trends in Professional Communication\nWeek 2 Sep 8 Getting the Message Across\nWeek 3 Sept 15 Planning and Writing Ethical AI (Quiz 1: Sept 16-18)\nWeek 4 Sep 22 Business Messages\nWeek 5 Sep 29 Business Style\nWeek 6 Oct 6 Routine and Goodwill Messages\nWeek 7 Oct 14 Informal Reports\nWeek 8 Oct 20 Formal Reports & Proposals (Quiz 2: Oct 21-23)\nWeek 9 Oct 27 Persuasive Messages (Proposal due Oct 30)\nWeek 10 Nov 3 Visual Communication & Presentations\nWeek 11 Nov 10 Term Break\nWeek 12 Nov 17 Communicating for Employment (Quiz 3: Nov 18-20)\nWeek 13 Nov 24 Social Media and Mobile Communication\nWeek 14 Dec 1 Final Report due Dec 3",
    );

    if (response is Ok<String>) {
      print(response.value);
      expect(response.value, contains("VCALENDAR"));
    } else {
      fail('LLMService returned error: ${(response as Error).error}');
    }
  }, timeout: const Timeout(Duration(minutes: 2)));
}
