// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercises_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExercisesResponseDto _$ExercisesResponseDtoFromJson(
  Map<String, dynamic> json,
) => ExercisesResponseDto(
  message: json['message'] as String?,
  totalExercises: (json['totalExercises'] as num?)?.toInt(),
  totalPages: (json['totalPages'] as num?)?.toInt(),
  currentPage: (json['currentPage'] as num?)?.toInt(),
  exercises: (json['exercises'] as List<dynamic>?)
      ?.map((e) => ExercisesDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ExercisesResponseDtoToJson(
  ExercisesResponseDto instance,
) => <String, dynamic>{
  'message': instance.message,
  'totalExercises': instance.totalExercises,
  'totalPages': instance.totalPages,
  'currentPage': instance.currentPage,
  'exercises': instance.exercises,
};
