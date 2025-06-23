// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workouts_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutsResponseDto _$WorkoutsResponseDtoFromJson(Map<String, dynamic> json) =>
    WorkoutsResponseDto(
      message: json['message'] as String?,
      musclesGroup: (json['musclesGroup'] as List<dynamic>?)
          ?.map((e) => MusclesGroupDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutsResponseDtoToJson(
        WorkoutsResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'musclesGroup': instance.musclesGroup,
    };
