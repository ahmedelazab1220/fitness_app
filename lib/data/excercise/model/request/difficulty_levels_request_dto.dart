import 'package:json_annotation/json_annotation.dart';

part 'difficulty_levels_request_dto.g.dart';

@JsonSerializable()
class DifficultyLevelsRequestDto {
  final String? muscleId;

  DifficultyLevelsRequestDto({this.muscleId});

  factory DifficultyLevelsRequestDto.fromJson(Map<String, dynamic> json) =>
      _$DifficultyLevelsRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DifficultyLevelsRequestDtoToJson(this);
}
