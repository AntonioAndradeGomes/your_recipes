import 'dart:developer';
import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';
import 'package:your_recipes/src/common/usecases/usecase.dart';
import 'package:your_recipes/src/features/auth/domain/entities/user_entity.dart';
import 'package:your_recipes/src/features/user_profile/data/datasources/profile_remote_datasource.dart';
import 'package:your_recipes/src/features/user_profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource _profileRemoteDatasource;

  ProfileRepositoryImpl({
    required ProfileRemoteDatasource datasource,
  }) : _profileRemoteDatasource = datasource;

  @override
  Stream<UserEntity?> authenticatedUserStream() =>
      _profileRemoteDatasource.authenticatedUserStream();

  @override
  Future<Result<NoParams, CustomException>> logout() async {
    try {
      await _profileRemoteDatasource.logout();
      return Result.success(NoParams());
    } catch (e, s) {
      log(
        'Erro no logout: ${e.toString()}',
        error: e,
        stackTrace: s,
      );
      return Result.failure(
        CustomException(
          customMessage: 'Houve erro no logout',
          messageError: e.toString(),
        ),
      );
    }
  }
}
