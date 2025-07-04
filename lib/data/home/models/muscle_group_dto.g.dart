// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscle_group_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MuscleGroupDto _$MuscleGroupDtoFromJson(Map<String, dynamic> json) =>
    MuscleGroupDto(
      message: json['message'] as String?,
      muscles: (json['musclesGroup'] as List<dynamic>?)
          ?.map((e) => MuscleDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MuscleGroupDtoToJson(MuscleGroupDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'musclesGroup': instance.muscles,
    };
