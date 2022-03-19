import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:logger/logger.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/services/authentication_service.dart';

// Consts
import 'package:my_app/consts/colours.dart' as Colours;
import 'package:my_app/consts/strings.dart' as Strings;

// Widgets
import 'package:my_app/screens/home/widgets/three_colour.dart';
import 'package:my_app/screens/home/widgets/full_colour.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _isSelected = false;
  late Color _colourSelected;

  final _logger = Logger();
  final _authService = locator<AuthenticationService>();

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    _logger.d("position logic");
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      _logger.d("location disabeled");
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.black,
        child: const Text("?"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Center buildBody() {
    return Center(
      child: FutureBuilder<Position>(
          future: _determinePosition(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _logger.d(snapshot.data.toString() +
                  " " +
                  snapshot.data!.altitude.toString() +
                  " " +
                  snapshot.data!.speed.toString());
            }
            if (_isSelected == false) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    Strings.appName,
                    style: TextStyle(
                      height: 0.05,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  ThreeColourComponenetWidget(
                      onSelected: _handleColourSelected,
                      colour: Colours.mainred),
                  const Text(
                    Strings.pickAColour,
                    style: TextStyle(
                      height: 0.05,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  ThreeColourComponenetWidget(
                    colour: Colours.mainblue,
                    onSelected: _handleColourSelected,
                  ),
                  ThreeColourComponenetWidget(
                    colour: Colours.mainbiege,
                    onSelected: _handleColourSelected,
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FullColourWidget(
                    colour: _colourSelected,
                    timerExpired: _handleTimerExpired,
                  ),
                ],
              );
            }
          }),
    );
  }

  void _handleColourSelected(Color colourVal) {
    setState(() {
      _isSelected = true;
      _colourSelected = colourVal;
    });
    _logger.d("$_colourSelected selected.");
    _logger.d(" isSelected is $_isSelected");
  }

  void _handleTimerExpired() {
    setState(() {
      _isSelected = false;
    });
    _logger.d(" isSelected is $_isSelected");
  }
}
