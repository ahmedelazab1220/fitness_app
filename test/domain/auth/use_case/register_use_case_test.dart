import 'package:fitness_app/data/auth/models/user_dto.dart';
import 'package:fitness_app/domain/auth/entity/register/register_request_entity.dart';
import 'package:fitness_app/domain/auth/repo/auth_repo.dart';
import 'package:fitness_app/domain/auth/use_case/register_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/data/auth/models/register/response/register_response_dto.dart';

import 'register_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late RegisterUseCase registerUseCase;
  late MockAuthRepo mockAuthRepo;

  // Provide dummy for generic dynamic results
  provideDummy<Result<dynamic>>(SuccessResult(null));
  provideDummy<Result<RegisterResponseDto>>(
    SuccessResult(
      RegisterResponseDto(
        message: "",
        token: "",
        user: UserDto(
          firstName: "",
          lastName: "",
          email: "",
          gender: "",
          age: 0,
          weight: 0,
          height: 0,
          activityLevel: "",
          goal: "",
          photo: "",
          id: "",
          createdAt: DateTime.now(),
        ),
      ),
    ),
  );

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    registerUseCase = RegisterUseCase(mockAuthRepo);
  });

  group("RegisterUseCase", () {
    test("should return SuccessResult when register is successful", () async {
      // Arrange
      final requestDto = RegisterRequestEntity(
        firstName: "Ahmed",
        lastName: "Abdelghany",
        email: "Ahmed.Abdelghany@example.com",
        password: "Ahmed@123",
        rePassword: "Ahmed@123",
        gender: "male",
        height: 180,
        weight: 75,
        age: 25,
        goal: "Lose Weight",
        activityLevel: "Active",
      );

      when(
        mockAuthRepo.register(requestDto),
      ).thenAnswer((_) async => SuccessResult<void>(null));

      // Act
      final result = await registerUseCase.call(requestDto);

      // Assert
      verify(mockAuthRepo.register(requestDto)).called(1);
      expect(result, isA<SuccessResult<RegisterResponseDto>>());
    });
  });
}
