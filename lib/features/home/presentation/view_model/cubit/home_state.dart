part of 'home_cubit.dart';

class HomeState extends Equatable {
  final BaseState? getDailyRecommendationExerciseState;
  final BaseState? getFoodRecommendationState;
  final BaseState? getUpcomingWorkoutState;
  final BaseState? getExerciseCategoriesState;
  final BaseState? getAllMuscelsState;

  const HomeState({
    this.getDailyRecommendationExerciseState,
    this.getFoodRecommendationState,
    this.getUpcomingWorkoutState,
    this.getExerciseCategoriesState,
    this.getAllMuscelsState,
  });

  HomeState copyWith({
    BaseState? getDailyRecommendationExerciseState,
    BaseState? getFoodRecommendationState,
    BaseState? getUpcomingWorkoutState,
    BaseState? getExerciseCategoriesState,
    BaseState? getAllMuscelsState,
  }) {
    return HomeState(
      getDailyRecommendationExerciseState:
          getDailyRecommendationExerciseState ??
          this.getDailyRecommendationExerciseState,
      getFoodRecommendationState:
          getFoodRecommendationState ?? this.getFoodRecommendationState,
      getUpcomingWorkoutState:
          getUpcomingWorkoutState ?? this.getUpcomingWorkoutState,
      getExerciseCategoriesState:
          getExerciseCategoriesState ?? this.getExerciseCategoriesState,
      getAllMuscelsState: getAllMuscelsState ?? this.getAllMuscelsState,
    );
  }

  @override
  List<Object?> get props => [
    getDailyRecommendationExerciseState,
    getFoodRecommendationState,
    getUpcomingWorkoutState,
    getExerciseCategoriesState,
    getAllMuscelsState,
  ];
}

sealed class HomeAction {}

final class GetDailyRecommendationExerciseAction extends HomeAction {}

final class GetFoodRecommendationAction extends HomeAction {}

final class GetUpcomingWorkoutAction extends HomeAction {}

final class GetExerciseCategoriesAction extends HomeAction {}

final class GetAllMuscelsAction extends HomeAction {}
