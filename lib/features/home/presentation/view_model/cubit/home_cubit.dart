import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/datasource_excution/api_result.dart';
import '../../../../../domain/home/entity/category_entity.dart';
import '../../../../../domain/home/entity/exercise_entity.dart';
import '../../../../../domain/home/entity/meal_entity.dart';
import '../../../../../domain/home/entity/muscle_entity.dart';
import '../../../../../domain/home/use_case/get_all_muscles_use_case.dart';
import '../../../../../domain/home/use_case/get_daily_recommendation_exercise_use_case.dart';
import '../../../../../domain/home/use_case/get_exercise_categories_use_case.dart';
import '../../../../../domain/home/use_case/get_food_recommendation_use_case.dart';
import '../../../../../domain/home/use_case/get_upcoming_workout_use_case.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetDailyRecommendationExerciseUseCase
  _getDailyRecommendationExerciseUseCase;
  final GetFoodRecommendationUseCase _getFoodRecommendationUseCase;
  final GetUpcomingWorkoutUseCase _getUpcomingWorkoutUseCase;
  final GetExerciseCategoriesUseCase _getExerciseCategoriesUseCase;
  final GetAllMusclesUseCase _getAllMusclesUseCase;

  HomeCubit(
    this._getDailyRecommendationExerciseUseCase,
    this._getFoodRecommendationUseCase,
    this._getUpcomingWorkoutUseCase,
    this._getExerciseCategoriesUseCase,
    this._getAllMusclesUseCase,
  ) : super(const HomeState());

  late List<CategoryEntity> exerciseCategories = [];
  late List<ExerciseEntity> upcomingWorkout = [];
  late List<ExerciseEntity> dailyRecommendation = [];
  late List<MealEntity> foodRecommendation = [];
  late List<MuscleEntity> muscles = [];

  Future<void> doIntent(HomeAction action) async {
    switch (action) {
      case GetDailyRecommendationExerciseAction():
        {
          _getDailyRecommendationExercise();
        }
      case GetFoodRecommendationAction():
        {
          _getFoodRecommendation();
        }
      case GetUpcomingWorkoutAction():
        {
          _getUpcomingWorkout();
        }
      case GetExerciseCategoriesAction():
        {
          _getExerciseCategories();
        }
      case GetAllMuscelsAction():
        {
          _getAllMuscles();
        }
    }
  }

  Future<void> _getDailyRecommendationExercise() async {
    emit(
      state.copyWith(getDailyRecommendationExerciseState: BaseLoadingState()),
    );
    final result = await _getDailyRecommendationExerciseUseCase(
      Constants.limit,
      Constants.targetMuscleGroupId,
      Constants.difficultyLevelId,
    );
    switch (result) {
      case SuccessResult<List<ExerciseEntity>>():
        {
          dailyRecommendation = result.data;
          emit(
            state.copyWith(
              getDailyRecommendationExerciseState: BaseSuccessState(),
            ),
          );
        }
      case FailureResult<List<ExerciseEntity>>():
        {
          emit(
            state.copyWith(
              getDailyRecommendationExerciseState: BaseErrorState(
                errorMessage: result.exception.toString(),
                exception: result.exception,
              ),
            ),
          );
        }
    }
  }

  Future<void> _getFoodRecommendation() async {
    emit(state.copyWith(getFoodRecommendationState: BaseLoadingState()));
    final result = await _getFoodRecommendationUseCase();
    switch (result) {
      case SuccessResult<List<MealEntity>>():
        {
          foodRecommendation = result.data;
          emit(state.copyWith(getFoodRecommendationState: BaseSuccessState()));
        }
      case FailureResult<List<MealEntity>>():
        {
          emit(
            state.copyWith(
              getFoodRecommendationState: BaseErrorState(
                errorMessage: result.exception.toString(),
                exception: result.exception,
              ),
            ),
          );
        }
    }
  }

  Future<void> _getUpcomingWorkout() async {
    emit(state.copyWith(getUpcomingWorkoutState: BaseLoadingState()));
    final result = await _getUpcomingWorkoutUseCase();
    switch (result) {
      case SuccessResult<List<ExerciseEntity>>():
        {
          upcomingWorkout = result.data;
          emit(state.copyWith(getUpcomingWorkoutState: BaseSuccessState()));
        }
      case FailureResult<List<ExerciseEntity>>():
        {
          emit(
            state.copyWith(
              getUpcomingWorkoutState: BaseErrorState(
                errorMessage: result.exception.toString(),
                exception: result.exception,
              ),
            ),
          );
        }
    }
  }

  Future<void> _getExerciseCategories() async {
    emit(state.copyWith(getExerciseCategoriesState: BaseLoadingState()));
    final result = await _getExerciseCategoriesUseCase();
    switch (result) {
      case SuccessResult<List<CategoryEntity>>():
        {
          exerciseCategories = result.data;
          emit(state.copyWith(getExerciseCategoriesState: BaseSuccessState()));
        }
      case FailureResult<List<CategoryEntity>>():
        {
          emit(
            state.copyWith(
              getExerciseCategoriesState: BaseErrorState(
                errorMessage: result.exception.toString(),
                exception: result.exception,
              ),
            ),
          );
        }
    }
  }

  Future<void> _getAllMuscles() async {
    emit(state.copyWith(getAllMuscelsState: BaseLoadingState()));
    final result = await _getAllMusclesUseCase();
    switch (result) {
      case SuccessResult<List<MuscleEntity>>():
        {
          muscles = result.data;
          emit(state.copyWith(getAllMuscelsState: BaseSuccessState()));
        }
      case FailureResult<List<MuscleEntity>>():
        {
          emit(
            state.copyWith(
              getAllMuscelsState: BaseErrorState(
                errorMessage: result.exception.toString(),
                exception: result.exception,
              ),
            ),
          );
        }
    }
  }
}
