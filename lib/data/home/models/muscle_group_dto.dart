import 'package:json_annotation/json_annotation.dart';

import 'muscle_dto.dart';

part 'muscle_group_dto.g.dart';

@JsonSerializable()
class MuscleGroupDto {
  final String? message;
  @JsonKey(name: 'musclesGroup')
  final List<MuscleDto>? muscles;

  MuscleGroupDto({this.message, this.muscles});

  factory MuscleGroupDto.fromJson(Map<String, dynamic> json) =>
      _$MuscleGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleGroupDtoToJson(this);
}
