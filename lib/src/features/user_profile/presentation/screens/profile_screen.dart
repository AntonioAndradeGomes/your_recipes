import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:your_recipes/providers.dart';
import 'package:your_recipes/src/common/routes/routes.dart';
import 'package:your_recipes/src/common/theme/dimensions.dart';
import 'package:your_recipes/src/common/utils/extensions.dart';
import 'package:your_recipes/src/features/user_profile/presentation/bloc/profile_bloc.dart';
import 'package:your_recipes/src/features/user_profile/presentation/screens/widgets/user_loading_widget.dart';
import 'package:your_recipes/src/features/user_profile/presentation/screens/widgets/user_profile_image_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _controller = getIt<ProfileBloc>();

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final textTheme = context.textTheme;
    return Scaffold(
      body: Column(
        children: [
          BlocProvider<ProfileBloc>(
            create: (context) => _controller,
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoadingState) {
                  return const UserLoadingWidget();
                }
                if (state is ProfileErrorState) {
                  return const SizedBox();
                }
                final user = state.userEntity!;
                return Column(
                  children: [
                    UserProfileImageWidget(
                      size: 80,
                      name: user.name,
                      image: user.photoUrl,
                    ),
                    Dimensions.verticalSpaceSmaller,
                    Text(
                      user.name,
                      style: textTheme.titleMedium?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      user.email,
                      style: textTheme.labelLarge,
                      textAlign: TextAlign.center,
                    ),
                    Dimensions.verticalSpaceSmallest,
                    Row(
                      children: [],
                    ),
                  ],
                );
              },
            ),
          ),
          UserLoadingWidget(),
          Center(
            child: FilledButton(
              child: const Text(
                'Sair',
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                context.go(RoutesLocation.splash);
              },
            ),
          ),
        ],
      ),
    );
  }
}
