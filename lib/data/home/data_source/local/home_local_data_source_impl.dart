import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/constants.dart';
import '../../models/category_dto.dart';
import '../contract/home_local_data_source.dart';

@Injectable(as: HomeLocalDataSource)
class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<List<CategoryDto>> getExerciseCategories() async {
    var response = await rootBundle.loadString(
      Constants.assetsFitnessAppHostedData,
    );
    final data = json.decode(response);
    List<CategoryDto> categories = (data[Constants.categories] as List)
        .map((item) => CategoryDto.fromJson(item))
        .toList();
    return categories;
  }
}
