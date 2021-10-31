import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color c;
  const MyButton({Key? key, required this.c}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('$c was tapped!');
      },
      child: Container(
        decoration: BoxDecoration(color: c),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: MyButton(c: Colors.black),
        ),
      ),
    ),
  );
}
