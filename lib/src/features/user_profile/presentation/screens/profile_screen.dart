import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:your_recipes/src/common/routes/routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seu Perfil'),
      ),
      body: Column(
        children: [
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
