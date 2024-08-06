import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';
import 'package:your_recipes/src/common/usecases/usecase.dart';
import 'package:your_recipes/src/features/auth/data/models/user_model.dart';
import 'package:your_recipes/src/features/auth/domain/entities/user_entity.dart';
import 'package:your_recipes/src/features/user_profile/data/datasources/profile_remote_datasource.dart';
import 'package:your_recipes/src/features/user_profile/data/repository/profile_repository_impl.dart';
import 'package:your_recipes/src/features/user_profile/domain/repository/profile_repository.dart';

class MockProfileRemoteDatasource extends Mock
    implements ProfileRemoteDatasource {}

void main() {
  late ProfileRepository repository;
  late ProfileRemoteDatasource datasource;

  setUp(() {
    datasource = MockProfileRemoteDatasource();
    repository = ProfileRepositoryImpl(
      datasource: datasource,
    );
  });

  group(
    'ProfileRepository',
    () {
      group(
        'authenticatedUserStream',
        () {
          test(
            'should return a stream of UserEntity when datasource returns a stream of UserModel',
            () async {
              final userModel = UserModel(
                id: 'user1',
                email: 'test@test.com',
                name: 'Test User',
                photoUrl: 'photoUrl',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                provide: 'Google',
              );

              when(
                () => datasource.authenticatedUserStream(),
              ).thenAnswer(
                (_) => Stream.value(userModel),
              );

              final result = repository.authenticatedUserStream();

              expectLater(
                result,
                emitsInOrder(
                  [
                    isA<UserEntity>(),
                  ],
                ),
              );

              verify(() => datasource.authenticatedUserStream()).called(1);
            },
          );

          test(
            'should return null when datasource returns null',
            () {
              when(
                () => datasource.authenticatedUserStream(),
              ).thenAnswer(
                (_) => Stream.value(null),
              );
              final result = repository.authenticatedUserStream();

              expectLater(
                result,
                emitsInOrder(
                  [
                    null,
                  ],
                ),
              );

              verify(() => datasource.authenticatedUserStream()).called(1);
            },
          );
        },
      );

      group(
        'Logout',
        () {
          test(
            'should return success when logout is successful',
            () async {
              when(() => datasource.logout()).thenAnswer(
                (_) async => Future.value(),
              );

              final result = await repository.logout();

              expect(result.isSuccess(), true);
              expect(result.isError(), false);
              expect(result.getOrNull(), isA<NoParams>());
              verify(() => datasource.logout()).called(1);
            },
          );

          test(
            'should return failure when logout fails',
            () async {
              final exception = Exception('Logout failed');
              when(() => datasource.logout()).thenThrow(exception);

              // Act
              final result = await repository.logout();
              expect(result.isSuccess(), false);
              expect(result.isError(), true);
              expect(result.exceptionOrNull(), isA<CustomException>());
              verify(() => datasource.logout()).called(1);
            },
          );
        },
      );
    },
  );
}
