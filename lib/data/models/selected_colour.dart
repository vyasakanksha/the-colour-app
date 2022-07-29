import 'package:flutter/widgets.dart';

class Colour {
  final Color colour;
  final DateTime timestamp;

  Colour({required this.colour, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'colour':
          '#${(colour.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}',
      'timestamp': timestamp,
    };
  }

  Colour.fromMap(Map<String, dynamic> colourMap)
      : colour = colourMap["details"],
        timestamp = colourMap["timestamp"];
}
