// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_coach_message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmartCoachMessageDto _$SmartCoachMessageDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['messageId', 'content']);
  return SmartCoachMessageDto(
    messageId: json['messageId'] as String,
    content: json['content'] as String,
    timestamp: json['timestamp'] as String?,
  );
}

Map<String, dynamic> _$SmartCoachMessageDtoToJson(
  SmartCoachMessageDto instance,
) => <String, dynamic>{
  'messageId': instance.messageId,
  'content': instance.content,
  'timestamp': instance.timestamp,
};
