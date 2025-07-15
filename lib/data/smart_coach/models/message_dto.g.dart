// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageDtoAdapter extends TypeAdapter<MessageDto> {
  @override
  final int typeId = 2;

  @override
  MessageDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageDto(
      userMessage: fields[0] as String,
      smartCoachMessage: fields[1] as String,
      timestamp: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MessageDto obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userMessage)
      ..writeByte(1)
      ..write(obj.smartCoachMessage)
      ..writeByte(2)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDto _$MessageDtoFromJson(Map<String, dynamic> json) => MessageDto(
      userMessage: json['userMessage'] as String,
      smartCoachMessage: json['smartCoachMessage'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$MessageDtoToJson(MessageDto instance) =>
    <String, dynamic>{
      'userMessage': instance.userMessage,
      'smartCoachMessage': instance.smartCoachMessage,
      'timestamp': instance.timestamp.toIso8601String(),
    };
