import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/consts/strings.dart' as _strings;
import 'package:my_app/screens/home/widgets/gallery.dart';

class FullColourWidget extends StatefulWidget {
  final Color colour;
  final Function timerExpired;
  final DateTime expiryTime;

  void _handleTimerExpired() {
    timerExpired;
  }

  const FullColourWidget({
    Key? key,
    required this.colour,
    required this.timerExpired,
    required this.expiryTime,
  }) : super(key: key);

  @override
  FullColourWidgetState createState() => FullColourWidgetState();
}

class FullColourWidgetState extends State<FullColourWidget> {
  final _logger = Logger();

  @override
  Widget build(BuildContext context) {
    var temp = widget.expiryTime;
    _logger.d("$temp exripy time");
    final difference = widget.expiryTime.difference(DateTime.now());
    final int difference_hr = difference.inHours;
    final int difference_min = difference.inMinutes - (difference.inHours * 60);
    final int difference_sec =
        difference.inSeconds - (difference.inMinutes * 60);
    _logger.d("$difference_hr Mins: $difference_min Sec: $difference_sec");
    return TweenAnimationBuilder<Duration>(
        duration: Duration(
            hours: difference.inHours,
            minutes: difference_min,
            seconds: difference_sec),
        tween: Tween(
            begin: Duration(
                hours: difference.inHours,
                minutes: difference_min,
                seconds: difference_sec),
            end: Duration.zero),
        onEnd: () {
          widget._handleTimerExpired();
          widget.timerExpired();
        },
        builder: (BuildContext context, Duration value, Widget? child) {
          final hours = value.inHours;
          final minutes = value.inMinutes % 60;
          final seconds = value.inSeconds % 60;
          return Container(
              margin: const EdgeInsets.only(
                  left: 10, top: 0, right: 10, bottom: 10),
              height: MediaQuery.of(context).size.height * 0.95,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                  color: widget.colour,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                    const SizedBox(width: 10),
                    Row(children: [
                      const SizedBox(width: 10),
                      Flexible(
                          child: Text('$hours:$minutes:$seconds',
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
                            _strings.appNameTitle,
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                              fontSize: 60,
                            )),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: TextButton.icon(
                          icon: const Icon(
                            Icons.arrow_forward,
                            size: 30.0,
                            color: Colors.white,
                          ),
                          label: const Text('To The Gallery',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Gallery()),
                            );
                          },
                        ))
                      ],
                    )
                  ])));
        });
  }
}
