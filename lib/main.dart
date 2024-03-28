import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:your_recipes/firebase_options.dart';
import 'package:your_recipes/locator.dart';
import 'package:your_recipes/src/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupLocator();
  runApp(
    const AppWidget(),
  );
}
