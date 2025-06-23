import 'package:fitness_app/domain/workouts/entity/muscles_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'muscles_dto.g.dart';

@JsonSerializable()
class Muscles {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "image")
  final String? image;

  Muscles({this.id, this.name, this.image});

  factory Muscles.fromJson(Map<String, dynamic> json) {
    return _$MusclesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesToJson(this);
  }

  MusclesEntity toEntity() {
    return MusclesEntity(id: id, name: name, image: image);
  }
}
