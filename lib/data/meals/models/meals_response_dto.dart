import 'package:fitness_app/data/meals/models/meals_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meals_response_dto.g.dart';

@JsonSerializable()
class MealsResponseDto {
  @JsonKey(name: "meals")
  final List<MealsDto>? meals;

  MealsResponseDto({this.meals});

  factory MealsResponseDto.fromJson(Map<String, dynamic> json) {
    return _$MealsResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsResponseDtoToJson(this);
  }
}
