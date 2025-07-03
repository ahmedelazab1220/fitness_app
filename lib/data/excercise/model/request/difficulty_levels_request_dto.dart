import 'package:json_annotation/json_annotation.dart';

part 'difficulty_levels_request_dto.g.dart';

@JsonSerializable()
class DifficultyLevelsRequestDto {
  final String? muscleId;

  DifficultyLevelsRequestDto({this.muscleId});
}
