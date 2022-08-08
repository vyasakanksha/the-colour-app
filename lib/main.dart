import 'package:flutter/material.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:logger/logger.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

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
  await _configureLocalTimeZone();

  setupLocator();

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runApp(ColourApp());
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(currentTimeZone));
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
