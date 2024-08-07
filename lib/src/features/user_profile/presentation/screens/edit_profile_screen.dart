import 'package:flutter/material.dart';
import 'package:your_recipes/src/common/theme/dimensions.dart';
import 'package:your_recipes/src/common/utils/extensions.dart';
import 'package:your_recipes/src/features/auth/domain/entities/user_entity.dart';
import 'package:your_recipes/src/features/user_profile/presentation/screens/widgets/user_profile_image_widget.dart';

class EditProfileScreen extends StatefulWidget {
  final UserEntity userEntity;
  const EditProfileScreen({
    super.key,
    required this.userEntity,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final textTheme = context.textTheme;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Editar Perfil',
          ),
        ),
        body: SingleChildScrollView(
          padding: Dimensions.paddingAllLarge,
          child: Column(
            children: [
              SizedBox(
                height: 110,
                width: 110,
                child: Stack(
                  children: [
                    UserProfileImageWidget(
                      size: 100,
                      name: widget.userEntity.name,
                      image: widget.userEntity.photoUrl,
                    ),
                    Positioned(
                      bottom: -2,
                      right: -4,
                      child: IconButton.filled(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Dimensions.verticalSpaceSmall,
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Nome',
                    style: textTheme.titleSmall?.copyWith(
                      color: colors.primary,
                    ),
                  ),
                  TextFormField(
                    initialValue: widget.userEntity.name,
                    decoration: const InputDecoration(
                      isDense: true,
                    ),
                  ),
                ],
              ),
              Dimensions.verticalSpaceSmall,
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Email',
                    style: textTheme.titleSmall?.copyWith(
                      color: colors.primary,
                    ),
                  ),
                  TextFormField(
                    initialValue: widget.userEntity.email,
                    readOnly: true,
                    decoration: const InputDecoration(
                      isDense: true,
                    ),
                  ),
                ],
              ),
              Dimensions.verticalSpaceMedium,
              SizedBox(
                width: 200,
                child: FilledButton(
                  onPressed: () {},
                  child: const Text(
                    'Editar Perfil',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
