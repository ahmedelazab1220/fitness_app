class SmartCoachMessageEntity {
  final String messageId;
  final String content;
  final String? timestamp;

  SmartCoachMessageEntity({
    required this.messageId,
    required this.content,
    this.timestamp,
  });
}
