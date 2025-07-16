import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/di/di.dart';
import 'package:fitness_app/core/utils/l10n/locale_keys.g.dart';
import 'package:fitness_app/features/main_layout/presentation/view/main_layout_screen.dart';
import 'package:fitness_app/features/main_layout/presentation/view_model/cubit/main_layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../test_constants.dart';
import 'main_layout_screen_test.mocks.dart';

@GenerateMocks([MainLayoutCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockMainLayoutCubit mockMainLayoutCubit;

  const String homeScreen = 'Home Screen';
  const String fitnessAIScreen = 'FitnessAI Screen';
  const String workoutsScreen = 'Workouts Screen';
  const String profileScreen = 'Profile Screen';

  // Setup EasyLocalization and dependency injection before tests
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    EasyLocalization.logger.enableLevels = [];
    EasyLocalization.logger.enableBuildModes = [];

    // Provide dummy value for MainLayoutState
    provideDummy<MainLayoutState>(MainLayoutInitial());
  });

  setUp(() {
    mockMainLayoutCubit = MockMainLayoutCubit();

    // Mock cubit properties
    when(mockMainLayoutCubit.currentTab).thenReturn(MainLayoutTabs.home);
    when(mockMainLayoutCubit.tabs).thenReturn({
      MainLayoutTabs.home: () => const Text(homeScreen),
      MainLayoutTabs.fitnessAI: () => const Text(fitnessAIScreen),
      MainLayoutTabs.workouts: () => const Text(workoutsScreen),
      MainLayoutTabs.profile: () => const Text(profileScreen),
    });

    // Mock cubit state and stream
    when(mockMainLayoutCubit.state).thenReturn(MainLayoutInitial());
    when(
      mockMainLayoutCubit.stream,
    ).thenAnswer((_) => Stream.value(MainLayoutInitial()));

    // Register mock cubit with getIt
    getIt.registerSingleton<MainLayoutCubit>(mockMainLayoutCubit);
  });

  tearDown(() {
    mockMainLayoutCubit.close();
    getIt.reset();
  });

  // Helper function to build the test widget
  Future<void> pumpMainLayoutScreen(
    WidgetTester tester, {
    Locale? locale,
  }) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [
          Locale(TestConstants.en),
          Locale(TestConstants.ar),
        ],
        path: TestConstants.assetsTranslations,
        fallbackLocale: const Locale(TestConstants.en),
        child: MaterialApp(home: const MainLayoutScreen(), locale: locale),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('MainLayoutScreen Test', () {
    testWidgets('renders MainLayoutScreen with initial state', (tester) async {
      await pumpMainLayoutScreen(tester);

      provideDummy<MainLayoutState>(MainLayoutInitial());

      expect(find.byType(MainLayoutScreen), findsOneWidget);
      expect(find.byType(AnimatedContainer), findsOneWidget);
      expect(find.byType(SvgPicture), findsExactly(4));

      expect(find.text(LocaleKeys.Home.tr()), findsOneWidget);
      expect(find.text(LocaleKeys.FitnessAI.tr()), findsNothing);
      expect(find.text(LocaleKeys.Workouts.tr()), findsNothing);
      expect(find.text(LocaleKeys.Profile.tr()), findsNothing);
    });
  });
}
