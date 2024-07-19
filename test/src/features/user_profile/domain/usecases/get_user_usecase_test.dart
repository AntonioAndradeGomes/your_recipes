import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:your_recipes/src/features/auth/domain/entities/user_entity.dart';
import 'package:your_recipes/src/features/user_profile/domain/repository/profile_repository.dart';
import 'package:your_recipes/src/features/user_profile/domain/usecases/get_user_usecase.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late GetUserUsecase usecase;
  late ProfileRepository profileRepository;

  setUp(() {
    profileRepository = MockProfileRepository();
    usecase = GetUserUsecase(
      repository: profileRepository,
    );
  });

  group(
    'GetUserUsecase',
    () {
      test(
        'should return a stream of UserEntity when called',
        () {
          final entity = UserEntity(
            id: 'teste',
            email: 'tetse@teste.com',
            name: 'Teste testando',
            photoUrl:
                'https://loja.usare.com.br/media/catalog/product/cache/1/image/400x400/9df78eab33525d08d6e5fb8d27136e95/p/e/pequena_2.jpg',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            provide: 'Google',
          );

          when(
            () => profileRepository.authenticatedUserStream(),
          ).thenAnswer(
            (invocation) => Stream.value(entity),
          );

          final result = usecase.call();
          expectLater(result, emitsInOrder([entity]));
          verify(() => profileRepository.authenticatedUserStream()).called(1);
        },
      );
      test(
        'should handle null user in stream',
        () {
          when(
            () => profileRepository.authenticatedUserStream(),
          ).thenAnswer(
            (invocation) => Stream.value(null),
          );

          final result = usecase.call();
          expectLater(result, emitsInOrder([null]));
          verify(() => profileRepository.authenticatedUserStream()).called(1);
        },
      );
    },
  );
}
