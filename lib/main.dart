import 'package:flutter/material.dart';
import 'colour.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Color App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pick a Colour'),
        ),
        body: const Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}
