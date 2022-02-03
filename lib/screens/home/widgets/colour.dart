import 'package:flutter/material.dart';

class ColourWidget extends StatelessWidget {
  final Color colour;
  const ColourWidget({
    Key? key,
    required this.colour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("$colour tapped."),
      child: Container(
        decoration: BoxDecoration(
          color: colour,
        ),
      ),
    );
  }
}
