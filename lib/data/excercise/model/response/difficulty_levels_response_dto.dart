import 'package:json_annotation/json_annotation.dart';

import 'difficulty_level_dto.dart';

part 'difficulty_levels_response_dto.g.dart';

@JsonSerializable()
class DifficultyLevelsResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "totalLevels")
  final int? totalLevels;
  @JsonKey(name: "difficulty_levels")
  final List<DifficultyLevelsDto>? difficultyLevels;

  DifficultyLevelsResponseDto({
    this.message,
    this.totalLevels,
    this.difficultyLevels,
  });

  factory DifficultyLevelsResponseDto.fromJson(Map<String, dynamic> json) {
    return _$DifficultyLevelsResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DifficultyLevelsResponseDtoToJson(this);
  }
}
