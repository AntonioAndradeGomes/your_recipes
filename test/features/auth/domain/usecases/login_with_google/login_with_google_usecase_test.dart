import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/features/auth/domain/repository/auth_repository.dart';
import 'package:your_recipes/features/auth/domain/usecases/login_with_google/login_with_google_usecase.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

void main() {
  group(
    'Tests in LoginWithGoogleUsecase',
    () {
      late AuthRepository repository;
      late LoginWithGoogleUsecase usecase;

      setUp(() {
        repository = AuthRepositoryMock();
        usecase = LoginWithGoogleUsecaseImp(
          repository: repository,
        );
      });
      test(
        'login success',
        () async {},
      );
    },
  );
}
