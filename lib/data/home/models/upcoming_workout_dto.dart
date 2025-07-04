import 'package:json_annotation/json_annotation.dart';

import 'exercise_dto.dart';

part 'upcoming_workout_dto.g.dart';

@JsonSerializable()
class UpcomingWorkoutDto {
  final String? message;
  final int? totalExercises;
  final int? totalPages;
  final int? currentPage;
  final List<ExerciseDto>? exercises;

  UpcomingWorkoutDto({
    this.message,
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    this.exercises,
  });

  factory UpcomingWorkoutDto.fromJson(Map<String, dynamic> json) =>
      _$UpcomingWorkoutDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpcomingWorkoutDtoToJson(this);
}
