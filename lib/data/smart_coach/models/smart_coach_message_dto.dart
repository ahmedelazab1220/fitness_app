import 'package:json_annotation/json_annotation.dart';

import '../../../domain/smart_coach/entity/smart_coach_message_entity.dart';

part 'smart_coach_message_dto.g.dart';

@JsonSerializable()
class SmartCoachMessageDto {
  @JsonKey(required: true)
  final String messageId;
  @JsonKey(required: true)
  final String content;
  @JsonKey(defaultValue: null)
  final String? timestamp;

  SmartCoachMessageDto({
    required this.messageId,
    required this.content,
    this.timestamp,
  });

  factory SmartCoachMessageDto.fromJson(Map<String, dynamic> json) =>
      _$SmartCoachMessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SmartCoachMessageDtoToJson(this);

  SmartCoachMessageEntity toEntity() => SmartCoachMessageEntity(
    messageId: messageId,
    content: content,
    timestamp: timestamp,
  );
}
