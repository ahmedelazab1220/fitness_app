// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionDtoAdapter extends TypeAdapter<SessionDto> {
  @override
  final int typeId = 1;

  @override
  SessionDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionDto(
      sessionId: fields[0] as String,
      title: fields[1] as String,
      messages: (fields[2] as List).cast<MessageDto>(),
      timestamp: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SessionDto obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.sessionId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.messages)
      ..writeByte(3)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionDto _$SessionDtoFromJson(Map<String, dynamic> json) => SessionDto(
      sessionId: json['sessionId'] as String,
      title: json['title'] as String,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => MessageDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$SessionDtoToJson(SessionDto instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'title': instance.title,
      'messages': instance.messages,
      'timestamp': instance.timestamp.toIso8601String(),
    };
