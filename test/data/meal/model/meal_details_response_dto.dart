import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_app/data/meals/model/meal_details_response_dto.dart';
import 'package:fitness_app/domain/meal/entity/meal_details_entity.dart';

void main() {
  group('MealDetailsDto.toEntity()', () {
    test('maps correctly from valid DTO', () {
      final dto = MealDetailsDto(
        idMeal: '123',
        strMeal: 'Test Meal',
        strCategory: 'Test Category',
        strArea: 'Test Area',
        strInstructions: 'Cook well',
        strMealThumb: 'https://image.com/thumb.jpg',
        strYoutube: 'https://youtube.com/test',
        strIngredient1: 'Rice',
        strIngredient2: 'Salt',
        strIngredient3: '',
        strIngredient4: null,
        strMeasure1: '1 cup',
        strMeasure2: '1 tsp',
        strMeasure3: '',
        strMeasure4: null,
      );

      final entity = dto.toEntity();

      expect(entity.idMeal, '123');
      expect(entity.strMeal, 'Test Meal');
      expect(entity.strInstructions, 'Cook well');
      expect(entity.strMealThumb, 'https://image.com/thumb.jpg');
      expect(entity.strYoutube, 'https://youtube.com/test');
      expect(entity.ingredients.length, 2);

      expect(entity.ingredients[0], Ingredient(name: 'Rice', measure: '1 cup'));
      expect(entity.ingredients[1], Ingredient(name: 'Salt', measure: '1 tsp'));
    });

    test('skips empty or null ingredients', () {
      final dto = MealDetailsDto(
        idMeal: '456',
        strMeal: 'Another Meal',
        strCategory: 'Category',
        strArea: 'Area',
        strInstructions: 'Instructions',
        strMealThumb: 'image',
        strYoutube: null,
        strIngredient1: '',
        strIngredient2: null,
        strIngredient3: 'Chicken',
        strMeasure1: '',
        strMeasure2: null,
        strMeasure3: '200g',
      );

      final entity = dto.toEntity();

      expect(entity.ingredients.length, 1);
      expect(entity.ingredients.first.name, 'Chicken');
      expect(entity.ingredients.first.measure, '200g');
    });
  });
}
