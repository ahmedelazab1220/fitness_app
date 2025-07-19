import 'package:fitness_app/core/functions/initial_route_function.dart';
import 'package:fitness_app/core/utils/constants.dart';
import 'package:fitness_app/core/utils/routes/app_routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'inital_route_function_test.mocks.dart';

@GenerateMocks([SharedPreferences, FlutterSecureStorage])
void main() {
  late RouteInitializer routeInitializer;
  late MockSharedPreferences mockPrefs;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    mockSecureStorage = MockFlutterSecureStorage();
    routeInitializer = RouteInitializer(
      flutterSecureStorage: mockSecureStorage,
      sharedPreferences: mockPrefs,
    );
  });

  group('RouteInitializer', () {
    test('returns onBoarding route when firstTime is false', () async {
      // Arrange
      when(mockPrefs.getBool(Constants.firstTime)).thenReturn(false);
      when(
        mockSecureStorage.read(key: Constants.token),
      ).thenAnswer((_) async => null);

      // Act
      final result = await routeInitializer.computeInitialRoute();

      // Assert
      expect(result, AppRoutes.onBoardingRoute);
      verify(mockPrefs.getBool(Constants.firstTime)).called(1);
    });

    test('returns login route when firstTime is true but no token', () async {
      // Arrange
      when(mockPrefs.getBool(Constants.firstTime)).thenReturn(true);
      when(
        mockSecureStorage.read(key: Constants.token),
      ).thenAnswer((_) async => null);

      // Act
      final result = await routeInitializer.computeInitialRoute();

      // Assert
      expect(result, AppRoutes.loginRoute);
    });

    test(
      'returns main route when firstTime is true and token exists',
      () async {
        // Arrange
        when(mockPrefs.getBool(Constants.firstTime)).thenReturn(true);
        when(
          mockSecureStorage.read(key: Constants.token),
        ).thenAnswer((_) async => 'valid_token');

        // Act
        final result = await routeInitializer.computeInitialRoute();

        // Assert
        expect(result, AppRoutes.mainLayoutRoute);
      },
    );
  });
}
