import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/l10n/locale_keys.g.dart';
import 'package:fitness_app/features/onBoarding/presentation/view/widgets/dot_items.dart';
import 'package:fitness_app/features/onBoarding/presentation/view/widgets/next_back_buttons.dart';
import 'package:fitness_app/features/onBoarding/presentation/view/widgets/on_boarding_page_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DotItems widget', () {
    testWidgets('active dot has width 24 and correct color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: DotItems(isActive: true))),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final BoxConstraints? constraints = container.constraints;
      expect(constraints?.maxWidth, 24);
      expect(constraints?.maxHeight, 8);
      final BoxDecoration decoration = container.decoration as BoxDecoration;
      expect(decoration.borderRadius, BorderRadius.circular(20));
    });

    testWidgets('inactive dot has width 8', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: DotItems(isActive: false))),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final BoxConstraints? constraints = container.constraints;
      expect(constraints?.maxWidth, 8);
    });
  });

  group('NextBackButtons widget', () {
    testWidgets('shows only Next on first page', (tester) async {
      bool nextCalled = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NextBackButtons(
              currentPage: 0,
              length: 3,
              onNext: () => nextCalled = true,
              onBack: () {},
            ),
          ),
        ),
      );

      expect(find.text(LocaleKeys.Next.tr()), findsOneWidget);
      await tester.tap(find.text(LocaleKeys.Next.tr()));
      expect(nextCalled, isTrue);
      expect(find.text(LocaleKeys.Back.tr()), findsNothing);
    });

    testWidgets('shows Back and Next on middle page', (tester) async {
      bool nextCalled = false;
      bool backCalled = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NextBackButtons(
              currentPage: 1,
              length: 3,
              onNext: () => nextCalled = true,
              onBack: () => backCalled = true,
            ),
          ),
        ),
      );

      expect(find.text(LocaleKeys.Next.tr()), findsOneWidget);
      expect(find.text(LocaleKeys.Back.tr()), findsOneWidget);
      await tester.tap(find.text(LocaleKeys.Back.tr()));
      expect(backCalled, isTrue);
      await tester.tap(find.text(LocaleKeys.Next.tr()));
      expect(nextCalled, isTrue);
    });

    testWidgets('shows Do It on last page', (tester) async {
      bool doItCalled = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NextBackButtons(
              currentPage: 2,
              length: 3,
              onNext: () => doItCalled = true,
              onBack: () {},
            ),
          ),
        ),
      );

      expect(find.text(LocaleKeys.DoIt.tr()), findsOneWidget);
      await tester.tap(find.text(LocaleKeys.DoIt.tr()));
      expect(doItCalled, isTrue);
    });
  });

  group('OnBoardingPageItem widget', () {
    const item = {'image': 'assets/images/onboarding1.png'};

    testWidgets('shows Skip when not last', (tester) async {
      bool skipCalled = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnBoardingPageItem(
              item: item,
              isLast: false,
              onSkip: () => skipCalled = true,
            ),
          ),
        ),
      );

      expect(find.text(LocaleKeys.Skip.tr()), findsOneWidget);
      await tester.tap(find.text(LocaleKeys.Skip.tr()));
      expect(skipCalled, isTrue);
    });

    testWidgets('hides Skip when last', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnBoardingPageItem(item: item, isLast: true, onSkip: () {}),
          ),
        ),
      );

      expect(find.text(LocaleKeys.Skip.tr()), findsNothing);
    });
  });
}
