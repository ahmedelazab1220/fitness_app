import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/session_entity.dart';
import '../entity/smart_coach_message_entity.dart';
import '../entity/user_message_entity.dart';

abstract class SmartCoachRepo {
  Future<Result<SmartCoachMessageEntity>> askSmartCoach(
    UserMessageEntity userMessageEntity,
    String sessionId,
  );

  Future<Result<Map<String, SessionEntity>>> getAllConversations();

  Future<Result<void>> deleteConversation(String sessionId);
}
