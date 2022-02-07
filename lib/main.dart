import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:localstore/localstore.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Consts
import 'package:my_app/consts/colours.dart' as Colours;
import 'package:my_app/consts/strings.dart' as Strings;

// Screens
import 'package:my_app/screens/home/screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  runApp(ColourApp());
}

class ColourApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      title: Strings.appName,
      home: HomeScreen(),
      navigatorKey: StackedService.navigatorKey,
    );
  }

  ThemeData buildTheme() {
    return ThemeData(
      primaryColor: Colours.primary,
    );
  }
}
