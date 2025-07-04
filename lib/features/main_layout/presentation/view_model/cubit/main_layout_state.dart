part of 'main_layout_cubit.dart';

sealed class MainLayoutState {}

final class MainLayoutInitial extends MainLayoutState {}

final class ScreenChangedState extends MainLayoutState {}

sealed class MainLayoutActions {}

final class ChangeSelectedTab extends MainLayoutActions {
  final MainLayoutTabs selectedTab;

  ChangeSelectedTab(this.selectedTab);
}

// final class ChangeTabWithWorkoutIndex extends MainLayoutActions {
//   final MainLayoutTabs selectedTab;
//   final int workoutIndex;

//   ChangeTabWithWorkoutIndex(this.selectedTab, this.workoutIndex);
// }

enum MainLayoutTabs { home, fitnessAI, workouts, profile }
