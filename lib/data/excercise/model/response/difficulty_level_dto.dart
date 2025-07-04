import 'package:json_annotation/json_annotation.dart';

part 'difficulty_level_dto.g.dart';

@JsonSerializable()
class DifficultyLevelsDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;

  DifficultyLevelsDto({this.id, this.name});

  factory DifficultyLevelsDto.fromJson(Map<String, dynamic> json) {
    return _$DifficultyLevelsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DifficultyLevelsDtoToJson(this);
  }
}
