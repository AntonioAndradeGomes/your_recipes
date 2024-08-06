import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';
import 'package:your_recipes/src/common/usecases/usecase.dart';
import 'package:your_recipes/src/features/user_profile/domain/repository/profile_repository.dart';
import 'package:your_recipes/src/features/user_profile/domain/usecases/logout_user_usecase.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late ProfileRepository mockProfileRepository;
  late LogoutUserUseCase useCase;

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    useCase = LogoutUserUseCase(
      repository: mockProfileRepository,
    );
  });

  group(
    'LogoutUserUseCase',
    () {
      test(
        'should call logout on the repository',
        () async {
          when(
            () => mockProfileRepository.logout(),
          ).thenAnswer(
            (_) async => Result.success(
              NoParams(),
            ),
          );
          final result = await useCase.call(NoParams());
          expect(result.isSuccess(), true);
          verify(() => mockProfileRepository.logout()).called(1);
        },
      );

      test(
        'should return a CustomException on failure',
        () async {
          when(
            () => mockProfileRepository.logout(),
          ).thenAnswer(
            (_) async => const Result.failure(
              CustomException(),
            ),
          );

          final result = await useCase.call(NoParams());
          expect(result.isSuccess(), false);
          expect(result.isError(), true);
          verify(() => mockProfileRepository.logout()).called(1);
        },
      );
    },
  );
}
