// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_workout_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingWorkoutDto _$UpcomingWorkoutDtoFromJson(Map<String, dynamic> json) =>
    UpcomingWorkoutDto(
      message: json['message'] as String?,
      totalExercises: (json['totalExercises'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
      exercises: (json['exercises'] as List<dynamic>?)
          ?.map((e) => ExerciseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpcomingWorkoutDtoToJson(UpcomingWorkoutDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'totalExercises': instance.totalExercises,
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
      'exercises': instance.exercises,
    };
