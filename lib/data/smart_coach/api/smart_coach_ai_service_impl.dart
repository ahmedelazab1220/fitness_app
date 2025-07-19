import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/l10n/locale_keys.g.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../models/message_dto.dart';
import '../models/smart_coach_message_dto.dart';
import '../models/user_message_dto.dart';
import 'smart_coach_ai_service.dart';

@LazySingleton(as: SmartCoachAiService)
class SmartCoachAiServiceImpl implements SmartCoachAiService {
  final GenerativeModel generativeModel;

  SmartCoachAiServiceImpl(this.generativeModel);

  @override
  Future<SmartCoachMessageDto> askSmartCoach(
    UserMessageDto userMessageDto,
    List<MessageDto> history,
  ) async {
    final historyText = history.isNotEmpty
        ? history
              .map(
                (msg) =>
                    '[${msg.userMessage == 'user' ? 'User' : 'FitSpark'}]: ${msg.smartCoachMessage}',
              )
              .join('\n')
        : 'No previous conversation history.';

    final prompt =
        '''
    You are FitSpark, a smart AI fitness coach. Always reply in a concise, friendly, and motivating tone to help the user stay on track with their fitness goals.
    
    💬 IMPORTANT:
    - Detect the language of the user's message and reply in the **same language**.
    - If the message is unclear, off-topic, or unrelated to fitness, **still provide a helpful fitness-related reply** (e.g. a motivational tip, workout suggestion, or healthy reminder). Never say you don't understand.
    
    Respond ONLY with a JSON object wrapped in a markdown code block using ```json. The object must contain **only** the "content" field.
    
    - The "content" should be a clear, helpful message that may optionally include:
      - Progress feedback (e.g. progress percentage, metric, and supportive feedback)
      - Workout suggestion (e.g. workout type, duration, list of exercises, and difficulty)
    - When including this optional information, format it as readable inline text or bullet points inside the "content" string.
    
    Here is the user's previous conversation:
    $historyText
    
    User's new message:
    "${userMessageDto.message}"
    
    Your reply must strictly follow this structure:
    
    ```json
    {
      "content": "<Your full response here, in the same language as the user's message, optionally including progress feedback and/or workout suggestion as part of the message>"
    }
    ```
    
    Respond ONLY with valid JSON inside the markdown code block. Do NOT include any other fields like 'messageId' or 'timestamp'. Do NOT include any other text or explanation outside the code block.
    ''';

    try {
      final content = await generativeModel.generateContent([
        Content.text(prompt),
      ]);

      final responseText = content.text?.trim() ?? '{}';

      final jsonMatch = RegExp(
        r'```json\n([\s\S]*?)\n```',
      ).firstMatch(responseText);
      var jsonString = jsonMatch?.group(1) ?? responseText;

      jsonString = jsonString.replaceAll('```', '').trim();

      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;

      return SmartCoachMessageDto(
        messageId: const Uuid().v4(),
        content: jsonMap['content'],
        timestamp: DateTime.now().toUtc().toIso8601String(),
      );
    } catch (e) {
      return SmartCoachMessageDto(
        messageId: const Uuid().v4(),
        content: LocaleKeys
            .OopsSomethingWentWrongLetsGetBackToFitnessTryAskingAboutYourNextWorkout.tr(),
        timestamp: DateTime.now().toUtc().toIso8601String(),
      );
    }
  }
}
