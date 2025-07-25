import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base/base_state.dart';

class MealDetailsState extends Equatable {
  final BaseState mealDetailsStatus;

  const MealDetailsState({required this.mealDetailsStatus});

  MealDetailsState copyWith({BaseState? mealDetailsStatus}) {
    return MealDetailsState(
      mealDetailsStatus: mealDetailsStatus ?? this.mealDetailsStatus,
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
