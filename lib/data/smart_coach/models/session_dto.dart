import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/smart_coach/entity/session_entity.dart';
import 'message_dto.dart';

part 'session_dto.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class SessionDto {
  @HiveField(0)
  String sessionId;
  @HiveField(1)
  String title;
  @HiveField(2)
  List<MessageDto> messages;
  @HiveField(3)
  DateTime timestamp;

  SessionDto({
    required this.sessionId,
    required this.title,
    required this.messages,
    required this.timestamp,
  });

  factory SessionDto.fromJson(Map<String, dynamic> json) =>
      _$SessionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SessionDtoToJson(this);

  SessionEntity toEntity() => SessionEntity(
    sessionId: sessionId,
    title: title,
    messages: messages.map((e) => e.toEntity(e)).toList(),
    timestamp: timestamp,
  );
}
