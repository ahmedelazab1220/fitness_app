import 'package:json_annotation/json_annotation.dart';

import '../../../domain/meal/entity/meal_details_entity.dart';

part 'meal_details_response_dto.g.dart';

@JsonSerializable()
class MealDetailsResponseDto {
  final List<MealDetailsDto> meals;

  MealDetailsResponseDto({required this.meals});

  factory MealDetailsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MealDetailsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MealDetailsResponseDtoToJson(this);
}

@JsonSerializable()
class MealDetailsDto {
  final String idMeal;
  final String strMeal;
  final String strCategory;
  final String strArea;
  final String strInstructions;
  final String strMealThumb;
  final String? strYoutube;

  final String? strIngredient1;
  final String? strIngredient2;
  final String? strIngredient3;
  final String? strIngredient4;
  final String? strIngredient5;
  final String? strIngredient6;
  final String? strIngredient7;
  final String? strIngredient8;
  final String? strIngredient9;
  final String? strIngredient10;
  final String? strIngredient11;
  final String? strIngredient12;
  final String? strIngredient13;
  final String? strIngredient14;
  final String? strIngredient15;
  final String? strIngredient16;
  final String? strIngredient17;
  final String? strIngredient18;
  final String? strIngredient19;
  final String? strIngredient20;

  final String? strMeasure1;
  final String? strMeasure2;
  final String? strMeasure3;
  final String? strMeasure4;
  final String? strMeasure5;
  final String? strMeasure6;
  final String? strMeasure7;
  final String? strMeasure8;
  final String? strMeasure9;
  final String? strMeasure10;
  final String? strMeasure11;
  final String? strMeasure12;
  final String? strMeasure13;
  final String? strMeasure14;
  final String? strMeasure15;
  final String? strMeasure16;
  final String? strMeasure17;
  final String? strMeasure18;
  final String? strMeasure19;
  final String? strMeasure20;

  MealDetailsDto({
    required this.idMeal,
    required this.strMeal,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    this.strYoutube,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strIngredient6,
    this.strIngredient7,
    this.strIngredient8,
    this.strIngredient9,
    this.strIngredient10,
    this.strIngredient11,
    this.strIngredient12,
    this.strIngredient13,
    this.strIngredient14,
    this.strIngredient15,
    this.strIngredient16,
    this.strIngredient17,
    this.strIngredient18,
    this.strIngredient19,
    this.strIngredient20,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5,
    this.strMeasure6,
    this.strMeasure7,
    this.strMeasure8,
    this.strMeasure9,
    this.strMeasure10,
    this.strMeasure11,
    this.strMeasure12,
    this.strMeasure13,
    this.strMeasure14,
    this.strMeasure15,
    this.strMeasure16,
    this.strMeasure17,
    this.strMeasure18,
    this.strMeasure19,
    this.strMeasure20,
  });

  factory MealDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$MealDetailsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MealDetailsDtoToJson(this);
}

extension MealDetailsDtoMapper on MealDetailsDto {
  MealDetailsEntity toEntity() {
    List<String> ingredients = [];
    List<String> measures = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = toJson()['strIngredient$i']?.toString().trim();
      final measure = toJson()['strMeasure$i']?.toString().trim();

      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add(ingredient);
        measures.add(measure ?? '');
      }
    }

    return MealDetailsEntity(
      idMeal: idMeal,
      strMeal: strMeal,
      strCategory: strCategory,
      strArea: strArea,
      strInstructions: strInstructions,
      strMealThumb: strMealThumb,
      strYoutube: strYoutube,
      ingredients: List.generate(
        ingredients.length,
        (index) =>
            Ingredient(name: ingredients[index], measure: measures[index]),
      ),
    );
  }
}

/*
www.themealdb.com/api/json/v1/1/lookup.php?i=52959

{
    "meals": [
        {
            "idMeal": "52959",
            "strMeal": "Baked salmon with fennel & tomatoes",
            "strMealAlternate": null,
            "strCategory": "Seafood",
            "strArea": "British",
            "strInstructions": "Heat oven to 180C/fan 160C/gas 4. Trim the fronds from the fennel and set aside. Cut the fennel bulbs in half, then cut each half into 3 wedges. Cook in boiling salted water for 10 mins, then drain well. Chop the fennel fronds roughly, then mix with the parsley and lemon zest.\r\n\r\nSpread the drained fennel over a shallow ovenproof dish, then add the tomatoes. Drizzle with olive oil, then bake for 10 mins. Nestle the salmon among the veg, sprinkle with lemon juice, then bake 15 mins more until the fish is just cooked. Scatter over the parsley and serve.",
            "strMealThumb": "https://www.themealdb.com/images/media/meals/1548772327.jpg",
            "strTags": "Paleo,Keto,HighFat,Baking,LowCarbs",
            "strYoutube": "https://www.youtube.com/watch?v=xvPR2Tfw5k0",
            "strIngredient1": "Fennel",
            "strIngredient2": "Parsley",
            "strIngredient3": "Lemon",
            "strIngredient4": "Cherry Tomatoes",
            "strIngredient5": "Olive Oil",
            "strIngredient6": "Salmon",
            "strIngredient7": "Black Olives",
            "strIngredient8": "",
            "strIngredient9": "",
            "strIngredient10": "",
            "strIngredient11": "",
            "strIngredient12": "",
            "strIngredient13": "",
            "strIngredient14": "",
            "strIngredient15": "",
            "strIngredient16": "",
            "strIngredient17": "",
            "strIngredient18": "",
            "strIngredient19": "",
            "strIngredient20": "",
            "strMeasure1": "2 medium",
            "strMeasure2": "2 tbs chopped",
            "strMeasure3": "Juice of 1",
            "strMeasure4": "175g",
            "strMeasure5": "1 tbs",
            "strMeasure6": "350g",
            "strMeasure7": "to serve",
            "strMeasure8": "",
            "strMeasure9": "",
            "strMeasure10": "",
            "strMeasure11": "",
            "strMeasure12": "",
            "strMeasure13": "",
            "strMeasure14": "",
            "strMeasure15": "",
            "strMeasure16": "",
            "strMeasure17": "",
            "strMeasure18": "",
            "strMeasure19": "",
            "strMeasure20": "",
            "strSource": "https://www.bbcgoodfood.com/recipes/7745/baked-salmon-with-fennel-and-tomatoes",
            "strImageSource": null,
            "strCreativeCommonsConfirmed": null,
            "dateModified": null
        }
    ]
}
*/
