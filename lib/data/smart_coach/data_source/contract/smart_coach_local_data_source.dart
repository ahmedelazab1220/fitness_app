import '../../models/message_dto.dart';
import '../../models/session_dto.dart';

abstract class SmartCoachLocalDataSource {
  Future<void> saveSmartCoachMessage(
    String userMessage,
    String smartCoachMessage,
    String title,
    String sessionId,
  );

  Future<Map<String, SessionDto>> getAllConversations();

  Future<void> deleteConversation(String sessionId);

  Future<List<MessageDto>> getLastTenMessagesInConversationBySessionId(
    String sessionId,
  );
}
