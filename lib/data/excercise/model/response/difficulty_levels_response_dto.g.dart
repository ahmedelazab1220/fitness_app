// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'difficulty_levels_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DifficultyLevelsResponseDto _$DifficultyLevelsResponseDtoFromJson(
  Map<String, dynamic> json,
) => DifficultyLevelsResponseDto(
  message: json['message'] as String?,
  totalLevels: (json['totalLevels'] as num?)?.toInt(),
  difficultyLevels: (json['difficulty_levels'] as List<dynamic>?)
      ?.map((e) => DifficultyLevelsDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DifficultyLevelsResponseDtoToJson(
  DifficultyLevelsResponseDto instance,
) => <String, dynamic>{
  'message': instance.message,
  'totalLevels': instance.totalLevels,
  'difficulty_levels': instance.difficultyLevels,
};
