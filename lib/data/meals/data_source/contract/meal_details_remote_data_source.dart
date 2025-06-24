import '../../model/meal_details_response_dto.dart';

abstract interface class MealsRemoteDataSource {
  Future<MealDetailsResponseDto> getMealDetails(String id);
}
