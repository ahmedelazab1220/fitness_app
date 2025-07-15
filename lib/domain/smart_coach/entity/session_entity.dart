import 'message_entity.dart';

class SessionEntity {
  final String sessionId;
  final List<MessageEntity> messages;
  final String title;
  final DateTime timestamp;

  SessionEntity({
    required this.sessionId,
    required this.messages,
    required this.title,
    required this.timestamp,
  });
}
