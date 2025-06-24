import 'package:fitness_app/core/base/base_state.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/meal/entity/meal_details_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/meal/use_case/meal_details_use_case.dart';
import 'meal_details_state.dart';

@injectable
class MealDetailsCubit extends Cubit<MealDetailsState> {
  final GetMealDetailsUseCase _getMealDetailsUseCase;
  final String mealId;
  MealDetailsCubit(this._getMealDetailsUseCase, @factoryParam this.mealId)
    : super(
        MealDetailsState(mealDetailsStatus: BaseInitialState(), mealId: mealId),
      );

  Future<void> getMealDetails(String id) async {
    emit(state.copyWith(mealDetailsStatus: BaseLoadingState()));
    final result = await _getMealDetailsUseCase(id);
    switch (result) {
      case SuccessResult<MealDetailsEntity>():
        emit(
          state.copyWith(
            mealDetailsStatus: BaseSuccessState(data: result.data),
          ),
        );
      case FailureResult<MealDetailsEntity>():
        emit(
          state.copyWith(
            mealDetailsStatus: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }
}
