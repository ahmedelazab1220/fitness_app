// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDtoAdapter extends TypeAdapter<UserDto> {
  @override
  final int typeId = 0;

  @override
  UserDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDto(
      firstName: fields[0] as String?,
      lastName: fields[1] as String?,
      photo: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserDto obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.photo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  id: json['_id'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  email: json['email'] as String?,
  gender: json['gender'] as String?,
  age: (json['age'] as num?)?.toInt(),
  weight: (json['weight'] as num?)?.toDouble(),
  height: (json['height'] as num?)?.toDouble(),
  activityLevel: json['activityLevel'] as String?,
  goal: json['goal'] as String?,
  photo: json['photo'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  '_id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'gender': instance.gender,
  'age': instance.age,
  'weight': instance.weight,
  'height': instance.height,
  'activityLevel': instance.activityLevel,
  'goal': instance.goal,
  'photo': instance.photo,
  'createdAt': instance.createdAt?.toIso8601String(),
};
