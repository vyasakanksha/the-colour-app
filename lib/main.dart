import 'package:flutter/material.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:logger/logger.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Consts
import 'package:my_app/consts/colours.dart' as _colours;
import 'package:my_app/consts/strings.dart' as _strings;

// Screens
import 'package:my_app/screens/home/screen.dart';

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator();

  runApp(ColourApp());
}

class ColourApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      title: _strings.appName,
      home: const HomeScreen(),
      navigatorKey: StackedService.navigatorKey,
    );
  }

  ThemeData buildTheme() {
    return ThemeData(
      primaryColor: _colours.primary,
    );
  }
}
