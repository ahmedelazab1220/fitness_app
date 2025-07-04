import 'package:json_annotation/json_annotation.dart';

part 'exercise_request_dto.g.dart';

@JsonSerializable()
class ExerciseRequestDto {
  final String? muscleId;
  final String? difficultyId;

  ExerciseRequestDto({this.muscleId, this.difficultyId});

  factory ExerciseRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ExerciseRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseRequestDtoToJson(this);
}
