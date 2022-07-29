import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:google_fonts/google_fonts.dart';

class ThreeColourComponenetWidget extends StatelessWidget {
  final Color colour;
  final ValueChanged<Color> onSelected;

  ThreeColourComponenetWidget(
      {Key? key, required this.onSelected, required this.colour})
      : super(key: key);

  // final bool selected;
  final _logger = Logger();

  void _handleTap() {
    onSelected(colour);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _logger.d("$colour tapped.");
        _handleTap();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 10),
        height: MediaQuery.of(context).size.height * .25,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
            color: colour,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}
