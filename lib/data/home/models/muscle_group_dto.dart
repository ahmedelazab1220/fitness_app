import 'package:json_annotation/json_annotation.dart';

import '../../../domain/home/entity/muscle_group_entity.dart';

part 'muscle_group_dto.g.dart';

@JsonSerializable()
class MuscleGroupDto {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;

  MuscleGroupDto({this.id, this.name});

  factory MuscleGroupDto.fromJson(Map<String, dynamic> json) =>
      _$MuscleGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleGroupDtoToJson(this);

  MuscleGroupEntity toEntity() => MuscleGroupEntity(id: id, name: name);
}
