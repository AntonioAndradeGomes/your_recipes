import 'package:your_recipes/src/features/auth/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Stream<UserEntity?> authenticatedUserStream();
}
