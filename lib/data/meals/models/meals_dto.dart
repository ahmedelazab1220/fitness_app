import 'package:fitness_app/domain/meals/entity/meal_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meals_dto.g.dart';

@JsonSerializable()
class MealsDto {
  @JsonKey(name: "strMeal")
  final String? strMeal;
  @JsonKey(name: "strMealThumb")
  final String? strMealThumb;
  @JsonKey(name: "idMeal")
  final String? idMeal;

  MealsDto({this.strMeal, this.strMealThumb, this.idMeal});

  factory MealsDto.fromJson(Map<String, dynamic> json) {
    return _$MealsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsDtoToJson(this);
  }

  MealEntity toEntity() {
    return MealEntity(
      idMeal: idMeal,
      strMeal: strMeal,
      strMealThumb: strMealThumb,
    );
  }
}
