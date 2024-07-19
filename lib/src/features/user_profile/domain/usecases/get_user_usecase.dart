import 'package:your_recipes/src/features/auth/domain/entities/user_entity.dart';
import 'package:your_recipes/src/features/user_profile/domain/repository/profile_repository.dart';

class GetUserUsecase {
  final ProfileRepository _profileRepository;

  GetUserUsecase({
    required ProfileRepository repository,
  }) : _profileRepository = repository;

  Stream<UserEntity?> call() => _profileRepository.authenticatedUserStream();
}
