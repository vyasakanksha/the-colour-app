import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ColourWidget extends StatelessWidget {
  final Color colour;
  final _logger = Logger();

  ColourWidget({
    Key? key,
    required this.colour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _logger.d("$colour tapped."),
      child: Container(
        decoration: BoxDecoration(
          color: colour,
        ),
      ),
    );
  }
}
