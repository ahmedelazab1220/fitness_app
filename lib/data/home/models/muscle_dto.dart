import 'package:json_annotation/json_annotation.dart';

import '../../../domain/home/entity/muscle_entity.dart';

part 'muscle_dto.g.dart';

@JsonSerializable()
class MuscleDto {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'image')
  final String? image;

  MuscleDto({this.id, this.name, this.image});

  factory MuscleDto.fromJson(Map<String, dynamic> json) =>
      _$MuscleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleDtoToJson(this);

  MuscleEntity toEntity() {
    return MuscleEntity(id: id, name: name, image: image);
  }
}
