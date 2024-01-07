import 'package:flutter/material.dart';
import 'package:your_recipes/app/app.dart';
import 'package:your_recipes/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(
    const MyApp(),
  );
}
