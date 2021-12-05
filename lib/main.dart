import 'package:flutter/material.dart';
import 'package:my_app/consts/colours.dart';

// Consts
import 'package:my_app/consts/strings.dart' as Strings;

// Screens
import 'package:my_app/screens/home/screen.dart';

void main() => runApp(
      ColourApp(),
    );

class ColourApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      title: Strings.appName,
      home: HomeScreen(),
    );
  }

  ThemeData buildTheme() {
    return ThemeData(
      primaryColor: primary,
    );
  }
}
