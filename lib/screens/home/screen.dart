import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:logger/logger.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:async/async.dart';

// Consts
import 'package:my_app/consts/colours.dart' as _colours;
import 'package:my_app/consts/strings.dart' as _strings;

// Widgets
import 'package:my_app/screens/home/widgets/three_colour.dart';
import 'package:my_app/screens/home/widgets/full_colour.dart';

// Services
import 'package:my_app/services/database_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final _databaseService = locator<DatabaseService>();

  bool _isSelected = false;
  late Color _colourSelected;
  dynamic _uuid;
  late DateTime? timestamp;
  late DateTime _expiryTime;

  final _logger = Logger();

  late AsyncMemoizer _memoizer;

  @override
  void initState() {
    super.initState();
    _memoizer = AsyncMemoizer();
    _getSession();

    // _databaseService.addDroplet().then((refID) {
    //   // _uuid = base.id;

    //   setState(() {
    //     _uuid = refID;
    //   });
    // });
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<dynamic> _determinePosition() async {
    return _memoizer.runOnce(() async {
      _logger.d("position logic");
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        _logger.d('Location services are disabled.');
        _databaseService.addLocationData(false, {}, _uuid);
        return false;
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
          _databaseService.addLocationData(false, {}, _uuid);
          _logger.d('Location permissions are denied');
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        _databaseService.addLocationData(false, {}, _uuid);
        _logger.d(
            'Location permissions are permanently denied, we cannot request permissions.');
        return false;
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // insert logic here
        },
        backgroundColor: Colors.black,
        child: const Text("?"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Center buildBody() {
    return Center(
      child: FutureBuilder<dynamic>(
          future: _determinePosition(),
          builder: (context, snapshot) {
            _logger.d("snapshot", snapshot.data);
            if (snapshot.hasData) {
              _logger.d(snapshot.data);
              if (snapshot.data == false) {
                _databaseService.addLocationData(false, {}, _uuid);
              } else {
                _databaseService.addLocationData(
                    true, snapshot.data!.toJson(), _uuid);
              }
            }
            if (_isSelected == false) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    _strings.appName,
                    style: TextStyle(
                      height: 0.05,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  ThreeColourComponenetWidget(
                      onSelected: _triggerColourSelected,
                      colour: _colours.mainred),
                  const Text(
                    _strings.pickAColour,
                    style: TextStyle(
                      height: 0.05,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  ThreeColourComponenetWidget(
                      colour: _colours.mainblue,
                      onSelected: _triggerColourSelected),
                  ThreeColourComponenetWidget(
                      colour: _colours.mainbiege,
                      onSelected: _triggerColourSelected),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FullColourWidget(
                    expiryTime: _expiryTime,
                    colour: _colourSelected,
                    timerExpired: _handleTimerExpired,
                  ),
                ],
              );
            }
          }),
    );
  }

  void _triggerColourSelected(Color colourVal) async {
    DateTime timestamp = DateTime.now();
    _handleColourSelected(colourVal, timestamp);
  }

  void _handleColourSelected(Color colourVal, DateTime timestamp) async {
    setState(() {
      _isSelected = true;
      _colourSelected = colourVal;
      _expiryTime = DateTime(timestamp.year, timestamp.month, timestamp.day,
          timestamp.hour, timestamp.minute + 1, timestamp.second);
    });

    _logger.d("$_colourSelected selected.");
    _logger.d(" isSelected is $_isSelected");
    _logger.d(" uudi is $_uuid");
    _databaseService.addColourData(colourVal, _uuid);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('expiry_time', _expiryTime.toString());
    prefs.setInt('colour_selected', _colourSelected.value);
    prefs.setBool('is_selected', _isSelected);
  }

  void _handleTimerExpired() async {
    _databaseService.addDroplet().then((refID) {
      // _uuid = base.id;

      setState(() {
        _uuid = refID;
      });
    });

    setState(() {
      _isSelected = false;
    });
    _logger.d(" isSelected is $_isSelected");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('expiry_time', "");
    prefs.setInt('colour_selected', 0);
    prefs.setBool('is_selected', false);
    prefs.setString('uuid', _uuid);
  }

  void _getSession() async {
    _logger.d("RETRIVE STATE");
    DateTime currentTimestamp = DateTime.now();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _expiryTime = DateTime.parse(prefs.getString('expiry_time') ?? "");
    _colourSelected = Color(prefs.getInt('colour_selected') ?? 0);
    _isSelected = prefs.getBool('is_selected') ?? false;
    _uuid = prefs.getString('uuid') ?? " ";

    if (_expiryTime.isBefore(DateTime.now()) || _isSelected == false) {
      _handleTimerExpired();
    } else {
      setState(() {
        _expiryTime = _expiryTime;
        _colourSelected = _colourSelected;
        _isSelected = _isSelected;
        _uuid = _uuid;
      });
      await FirebaseAnalytics.instance.logEvent(
        name: "Retrive_State",
        parameters: {
          "timestamp": timestamp,
          "colourSelected": _colourSelected,
          "_isSelected": _isSelected,
        },
      );
      _logger.d("$timestamp and $_colourSelected from shared.");
    }
  }

  // Future<void> _createUserSession() async {
  //   // _localStorageService.setItem('selected', true.toString());
  //   // _localStorageService.setItem('uuid', _uuid.toString());
  //   // _localStorageService.setItem('colour', _colourSelected.toString());
  //   // _localStorageService.setItem('time', )
  //   _timeOut = DateTime.now();

  //   final response = await _databaseService.create(
  //     AppUser(
  //       id: _uuid.toString(),
  //       timeIn: _timeIn,
  //       timeOut: _timeOut,
  //     ).toJson(),
  //   );

  //   if (response.error != null) {
  //     _logger.e(response.error!.message);
  //     return;
  //   }

  //   final data = AppUser.fromJson(response.data[0]);
  // }
}
