import 'package:fitness_app/data/meals/models/categories_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categories_response_dto.g.dart';

@JsonSerializable()
class CategoriesResponseDto {
  @JsonKey(name: "categories")
  final List<CategoriesDto>? categories;

  CategoriesResponseDto({this.categories});

  factory CategoriesResponseDto.fromJson(Map<String, dynamic> json) {
    return _$CategoriesResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoriesResponseDtoToJson(this);
  }
}
