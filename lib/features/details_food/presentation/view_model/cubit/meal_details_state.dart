import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base/base_state.dart';

class MealDetailsState extends Equatable {
  final BaseState mealDetailsStatus;
  final String mealId;

  const MealDetailsState({
    required this.mealId,
    required this.mealDetailsStatus,
  });

  MealDetailsState copyWith({BaseState? mealDetailsStatus}) {
    return MealDetailsState(
      mealDetailsStatus: mealDetailsStatus ?? this.mealDetailsStatus,
      mealId: mealId,
    );
  }

  @override
  List<Object?> get props => [mealDetailsStatus];
}

sealed class MealDetailsAction {}

class GetMealDetailsAction extends MealDetailsAction {
  final String mealId;

  GetMealDetailsAction(this.mealId);
}
