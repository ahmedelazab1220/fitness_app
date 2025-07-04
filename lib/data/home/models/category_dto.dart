import 'package:json_annotation/json_annotation.dart';

import '../../../domain/home/entity/category_entity.dart';

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDto {
  @JsonKey(name: 'title_en')
  final String? titleEn;
  @JsonKey(name: 'title_ar')
  final String? titleAr;
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  const CategoryDto({this.titleEn, this.titleAr, this.imageUrl});

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);

  CategoryEntity toEntity() =>
      CategoryEntity(titleEn: titleEn, titleAr: titleAr, imageUrl: imageUrl);
}
