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
}
