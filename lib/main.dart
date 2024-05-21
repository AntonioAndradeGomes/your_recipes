import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_recipes/firebase_options.dart';
import 'package:your_recipes/locator.dart';
import 'package:your_recipes/src/app_widget.dart';
import 'package:your_recipes/src/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupLocator();
  runApp(
    MultiProvider(
      providers: providers,
      child: const AppWidget(),
    ),
  );
}
