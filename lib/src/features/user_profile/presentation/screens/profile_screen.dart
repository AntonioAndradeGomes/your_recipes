import 'package:flutter/material.dart';
import 'package:your_recipes/src/features/auth/data/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel userModel;
  const ProfileScreen({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seu Perfil'),
      ),
      body: Center(
        child: FilledButton(
          child: const Text(
            'Sair',
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
