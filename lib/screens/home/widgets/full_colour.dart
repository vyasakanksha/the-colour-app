import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/consts/strings.dart' as Strings;
import 'package:my_app/consts/colours.dart' as Colours;
import 'dart:async';

import 'package:my_app/screens/home/screen.dart';

class FullColourWidget extends StatefulWidget {
  final Color colour;
  final Function timerExpired;

  void _handleTimerExpired() {
    timerExpired;
  }

  const FullColourWidget({
    Key? key,
    required this.colour,
    required this.timerExpired,
  }) : super(key: key);

  @override
  FullColourWidgetState createState() => FullColourWidgetState();
}

class FullColourWidgetState extends State<FullColourWidget> {
  final _logger = Logger();

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Duration>(
        duration: Duration(minutes: 0, seconds: 2),
        tween:
            Tween(begin: Duration(minutes: 0, seconds: 2), end: Duration.zero),
        onEnd: () {
          widget._handleTimerExpired();
          widget.timerExpired();
        },
        builder: (BuildContext context, Duration value, Widget? child) {
          final minutes = value.inMinutes;
          final seconds = value.inSeconds % 60;
          return Container(
              margin: const EdgeInsets.only(
                  left: 10, top: 0, right: 10, bottom: 10),
              height: MediaQuery.of(context).size.height * 0.95,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                  color: widget.colour,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                    const SizedBox(width: 10),
                    Row(children: [
                      const SizedBox(width: 10),
                      Flexible(
                          child: Text('$minutes:$seconds',
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 48,
                              )),
                              textAlign: TextAlign.left)),
                    ]),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            Strings.appNameTitle,
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                              fontSize: 60,
                            )),
                            textAlign: TextAlign.left,
                          ),
                        )
                      ],
                    ),
                  ])));
        });
  }
}
