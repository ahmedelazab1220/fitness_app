import 'package:json_annotation/json_annotation.dart';

import 'exercises_dto.dart';

part 'exercises_response_dto.g.dart';

@JsonSerializable()
class ExercisesResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "totalExercises")
  final int? totalExercises;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "exercises")
  final List<ExercisesDto>? exercises;

  ExercisesResponseDto({
    this.message,
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    this.exercises,
  });

  factory ExercisesResponseDto.fromJson(Map<String, dynamic> json) {
    return _$ExercisesResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExercisesResponseDtoToJson(this);
  }
}
