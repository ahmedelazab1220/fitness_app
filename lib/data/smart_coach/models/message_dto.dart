import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/smart_coach/entity/message_entity.dart';

part 'message_dto.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class MessageDto {
  @HiveField(0)
  final String userMessage;
  @HiveField(1)
  final String smartCoachMessage;
  @HiveField(2)
  final DateTime timestamp;

  MessageDto({
    required this.userMessage,
    required this.smartCoachMessage,
    required this.timestamp,
  });

  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);

  MessageEntity toEntity(MessageDto messageDto) => MessageEntity(
    userMessage: messageDto.userMessage,
    smartCoachMessage: messageDto.smartCoachMessage,
    timestamp: messageDto.timestamp,
  );
}
