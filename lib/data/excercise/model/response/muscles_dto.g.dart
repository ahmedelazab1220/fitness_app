// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscles_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusclesDto _$MusclesDtoFromJson(Map<String, dynamic> json) => MusclesDto(
  id: json['_id'] as String?,
  name: json['name'] as String?,
  image: json['image'] as String?,
);

Map<String, dynamic> _$MusclesDtoToJson(MusclesDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };
