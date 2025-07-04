import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../chat_bot/presentation/view/chat_bot_screen.dart';
import '../../../../home/presentation/view/home_screen.dart';
import '../../../../profile/presentation/view/screens/profile_screen.dart';
import '../../../../workouts/presentation/view/workouts_screen.dart';

part 'main_layout_state.dart';

@singleton
class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit() : super(MainLayoutInitial()) {
    _initTabs();
  }

  MainLayoutTabs currentTab = MainLayoutTabs.home;

  late final Map<MainLayoutTabs, Widget Function()> tabs;

  void _initTabs() {
    tabs = {
      MainLayoutTabs.home: () => const HomeScreen(),
      MainLayoutTabs.fitnessAI: () => const ChatBotScreen(),
      MainLayoutTabs.workouts: () => const WorkoutsScreen(),
      MainLayoutTabs.profile: () => ProfileScreen(),
    };
  }

  void doIntent(MainLayoutActions action) {
    switch (action) {
      case ChangeSelectedTab():
        _changeSelectedTab(action.selectedTab);
        break;

      // case ChangeTabWithWorkoutIndex():
      //   _changeTabWithWorkoutIndex(action.selectedTab, action.workoutIndex);
      //   break;
    }
  }

  // void _changeTabWithWorkoutIndex(
  //   MainLayoutTabs selectedTab,
  //   int workoutIndex,
  // ) {
  //   currentTab = selectedTab;

  //   tabs[MainLayoutTabs.workouts] = () =>
  //       WorkoutsScreen(workoutIndex: workoutIndex);

  //   emit(ScreenChangedState());

  //   Future.delayed(const Duration(milliseconds: 100), () {
  //     tabs[MainLayoutTabs.workouts] = () => const WorkoutsScreen();
  //   });
  // }

  void _changeSelectedTab(MainLayoutTabs selectedTab) {
    if (currentTab != selectedTab) {
      currentTab = selectedTab;
      emit(ScreenChangedState());
    }
  }
}
