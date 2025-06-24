import 'package:fitness_app/features/details_food/presentation/view/widgets/meal_header_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_player/video_player.dart';

void main() {
  testWidgets('🧪 renders fallback image when video is not initialized', (
    WidgetTester tester,
  ) async {
    const fakeVideoUrl = '';
    const fakeFallbackImage = 'https://fakeimage.com/image.jpg';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MealHeaderVideo(
            videoUrl: fakeVideoUrl,
            fallbackImage: fakeFallbackImage,
          ),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(VideoPlayer), findsNothing);

    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });
}
