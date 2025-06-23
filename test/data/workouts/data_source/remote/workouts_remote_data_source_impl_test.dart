import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/data/workouts/api/workouts_retrofit_client.dart';
import 'package:fitness_app/data/workouts/data_source/remote/workouts_remote_data_source_impl.dart';
import 'package:fitness_app/data/workouts/models/workouts_response_dto.dart';
import 'package:fitness_app/data/workouts/models/muscles_response_dto.dart';

import 'workouts_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([WorkoutsRetrofitClient])
void main() {
  late WorkoutsRemoteDataSourceImpl remoteDataSource;
  late MockWorkoutsRetrofitClient mockClient;

  setUp(() {
    mockClient = MockWorkoutsRetrofitClient();
    remoteDataSource = WorkoutsRemoteDataSourceImpl(mockClient);
  });

  group("Workouts Remote Data Source Test", () {
    group("getAllMuscleGroups", () {
      test("should return WorkoutsResponseDto", () async {
        // Arrange
        final expectedResponse = WorkoutsResponseDto(
          message: 'success',
          musclesGroup: [],
        );
        when(
          mockClient.getAllMuscleGroups(),
        ).thenAnswer((_) async => expectedResponse);

        // Act
        final result = await remoteDataSource.getAllMuscleGroups();

        // Assert
        verify(mockClient.getAllMuscleGroups()).called(1);
        expect(result, isA<WorkoutsResponseDto>());
      });

      test("should throw exception when API fails", () {
        // Arrange
        final exception = Exception('API error');
        when(
          mockClient.getAllMuscleGroups(),
        ).thenAnswer((_) async => throw exception);

        // Act
        final result = remoteDataSource.getAllMuscleGroups();

        // Assert
        verify(mockClient.getAllMuscleGroups()).called(1);
        expect(result, throwsA(isA<Exception>()));
      });
    });

    group("getAllMusclesByMuscleGroup", () {
      test("should return MusclesResponseDto", () async {
        // Arrange
        const muscleGroupId = '123';
        final expectedResponse = MusclesResponseDto(
          message: 'success',
          muscles: [],
          muscleGroup: null,
        );
        when(
          mockClient.getAllMusclesByMuscleGroup(muscleGroupId),
        ).thenAnswer((_) async => expectedResponse);

        // Act
        final result = await remoteDataSource.getAllMusclesByMuscleGroup(
          muscleGroupId,
        );

        // Assert
        verify(mockClient.getAllMusclesByMuscleGroup(muscleGroupId)).called(1);
        expect(result, isA<MusclesResponseDto>());
      });

      test("should throw exception when API fails", () {
        // Arrange
        const muscleGroupId = '123';
        final exception = Exception('API error');
        when(
          mockClient.getAllMusclesByMuscleGroup(muscleGroupId),
        ).thenAnswer((_) async => throw exception);

        // Act
        final result = remoteDataSource.getAllMusclesByMuscleGroup(
          muscleGroupId,
        );

        // Assert
        verify(mockClient.getAllMusclesByMuscleGroup(muscleGroupId)).called(1);
        expect(result, throwsA(isA<Exception>()));
      });
    });
  });
}
