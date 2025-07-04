import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/features/chat_bot/presentation/view/chat_bot_screen.dart';
import 'package:fitness_app/features/home/presentation/view/home_screen.dart';
import 'package:fitness_app/features/main_layout/presentation/view_model/cubit/main_layout_cubit.dart';
import 'package:fitness_app/features/profile/presentation/view/screens/profile_screen.dart';
import 'package:fitness_app/features/workouts/presentation/view/workouts_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MainLayoutCubit cubit;

  setUp(() {
    cubit = MainLayoutCubit();
  });

  tearDown(() {
    cubit.close();
  });

  group('MainLayoutCubit', () {
    test('initial state is MainLayoutInitial', () {
      expect(cubit.state, isA<MainLayoutInitial>());
      expect(cubit.currentTab, MainLayoutTabs.home);
    });

    test('tabs are initialized correctly', () {
      expect(cubit.tabs.length, 4);
      expect(cubit.tabs[MainLayoutTabs.home]?.call(), isA<HomeScreen>());
      expect(
        cubit.tabs[MainLayoutTabs.fitnessAI]?.call(),
        isA<ChatBotScreen>(),
      );
      expect(
        cubit.tabs[MainLayoutTabs.workouts]?.call(),
        isA<WorkoutsScreen>(),
      );
      expect(cubit.tabs[MainLayoutTabs.profile]?.call(), isA<ProfileScreen>());
    });

    blocTest<MainLayoutCubit, MainLayoutState>(
      'emits ScreenChangedState when changing to a different tab',
      build: () => cubit,
      act: (cubit) =>
          cubit.doIntent(ChangeSelectedTab(MainLayoutTabs.fitnessAI)),
      expect: () => [isA<ScreenChangedState>()],
      verify: (cubit) {
        expect(cubit.currentTab, MainLayoutTabs.fitnessAI);
      },
    );

    blocTest<MainLayoutCubit, MainLayoutState>(
      'does not emit state when selecting the same tab',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(ChangeSelectedTab(MainLayoutTabs.home)),
      expect: () => [],
      verify: (cubit) {
        expect(cubit.currentTab, MainLayoutTabs.home);
      },
    );
  });
}
