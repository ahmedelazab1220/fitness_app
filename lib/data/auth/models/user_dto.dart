import 'package:json_annotation/json_annotation.dart';

import '../../../domain/auth/entity/user_entity.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "age")
  final int? age;
  @JsonKey(name: "weight")
  final double? weight;
  @JsonKey(name: "height")
  final double? height;
  @JsonKey(name: "activityLevel")
  final String? activityLevel;
  @JsonKey(name: "goal")
  final String? goal;
  @JsonKey(name: "photo")
  final String? photo;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;

  UserDto({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.activityLevel,
    this.goal,
    this.photo,
    this.createdAt,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  UserEntity toEntity() => UserEntity(
    id: id,
    firstName: firstName,
    lastName: lastName,
    email: email,
    gender: gender,
    age: age,
    weight: weight,
    height: height,
    activityLevel: activityLevel,
    goal: goal,
    photo: photo,
    createdAt: createdAt,
  );
}
