import 'package:fitness_app/data/workouts/models/muscles_group_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'muscles_dto.dart';

part 'muscles_response_dto.g.dart';

@JsonSerializable()
class MusclesResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "muscleGroup")
  final MusclesGroupDto? muscleGroup;
  @JsonKey(name: "muscles")
  final List<Muscles>? muscles;

  MusclesResponseDto({this.message, this.muscleGroup, this.muscles});

  factory MusclesResponseDto.fromJson(Map<String, dynamic> json) {
    return _$MusclesResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesResponseDtoToJson(this);
  }
}
