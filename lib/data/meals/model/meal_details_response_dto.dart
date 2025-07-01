import 'package:fitness_app/data/meals/model/meal_details_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_details_response_dto.g.dart';

@JsonSerializable()
class MealDetailsResponseDto {
  final List<MealDetailsDto> meals;

  MealDetailsResponseDto({required this.meals});

  factory MealDetailsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MealDetailsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MealDetailsResponseDtoToJson(this);
}
