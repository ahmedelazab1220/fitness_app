// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscles_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusclesResponseDto _$MusclesResponseDtoFromJson(Map<String, dynamic> json) =>
    MusclesResponseDto(
      message: json['message'] as String?,
      muscleGroup: json['muscleGroup'] == null
          ? null
          : MusclesGroupDto.fromJson(
              json['muscleGroup'] as Map<String, dynamic>),
      muscles: (json['muscles'] as List<dynamic>?)
          ?.map((e) => MusclesDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MusclesResponseDtoToJson(MusclesResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'muscleGroup': instance.muscleGroup,
      'muscles': instance.muscles,
    };
