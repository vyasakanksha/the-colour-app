import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:device_info_plus/device_info_plus.dart';

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
import 'package:my_app/services/notification_service.dart';

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

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _memoizer = AsyncMemoizer();
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      SharedPreferences prefs = sp;
      _logger.d("INIT FUNCTION");
      final keys = prefs.getKeys();

      final prefsMap = Map<String, dynamic>();
      for (String key in keys) {
        prefsMap[key] = prefs.get(key);
      }
      _logger.d("SHARED PREF $prefsMap");
      String? uuidRef = prefs.getString('uuid');
      _logger.d("RETRIVE STATE uudi is 1 $uuidRef, 2 $_uuid");
      if (uuidRef == null) {
        _databaseService.addDroplet().then((refID) {
          _logger.d("CREATE NEW UUID $refID");

          setState(() {
            _uuid = refID;
          });
          prefs.setString('uuid', _uuid);
        });
      } else {
        setState(() {
          _uuid = uuidRef;
        });
      }
      _logger.d("RETRIVE STATE AFTER uudi is $_uuid");
    });
    _getSession();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    //Initialization Settings for iOS
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    //InitializationSettings for initializing settings for both platforms (Android & iOS)
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

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
          onInfoNotification();
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
            _logger.d("snapshop data, $snapshot $_uuid");
            if (snapshot.hasData) {
              if (snapshot.data == false) {
                _databaseService.addLocationData(false, {}, _uuid);
              } else {
                // var querySnapshot = snapshot.data;
                // var result = Map.fromIterable(querySnapshot);
                // Map<String, String> converted = {};
                // for (var item in result.keys) {
                //   converted[item.toString()] = result[item].toString();
                // }

                // _logger.d(
                //   "SNAPSHOT DATA ITEM2 $result",
                // );

                _databaseService.addLocationData(
                    true, snapshot.data!.toJson(), _uuid);
              }
            }
            if (_isSelected == false) {
              _logger.d(
                "is selectd false $_isSelected",
              );
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
              _logger.d("is selectd true $_isSelected");
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
    _logger.d("TRIGGER COLOR SELECTED");

    // TimeZone
    DateTime timestamp = DateTime.now();
    _databaseService.addTimeZoneData(timestamp.timeZoneName, _uuid);

    // Device Details
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final map = deviceInfo.toMap();
    _databaseService.addDeviceDetailsData(map, _uuid);

    // Colour
    _handleColourSelected(colourVal, timestamp);
  }

  void _handleColourSelected(Color colourVal, DateTime timestamp) async {
    _logger.d("COLOR SELECTED");
    setState(() {
      _isSelected = true;
      _colourSelected = colourVal;
      _expiryTime = DateTime(timestamp.year, timestamp.month, timestamp.day,
          timestamp.hour + 24, timestamp.minute, timestamp.second);
    });

    _logger.d("$_colourSelected selected.");
    _logger.d(" isSelected is $_isSelected");
    _logger.d(" uudi is $_uuid");
    _databaseService.addColourData(colourVal, _uuid);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('expiry_time', _expiryTime.toString());
    prefs.setInt('colour_selected', _colourSelected.value);
    prefs.setBool('is_selected', _isSelected);
    _showNotificationWithDefaultSound();
  }

  void _handleTimerExpired() async {
    _logger.d("TIMER EXPIRED");
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
    String? _expiryTimeTemp = prefs.getString('expiry_time');
    if (_expiryTimeTemp != null) {
      _expiryTime = DateTime.parse(prefs.getString('expiry_time') ?? "");
    }
    _colourSelected = Color(prefs.getInt('colour_selected') ?? 0);
    _isSelected = prefs.getBool('is_selected') ?? false;

    if (_expiryTimeTemp != null && _expiryTime.isBefore(DateTime.now())) {
      _handleTimerExpired();
    } else {
      setState(() {
        _expiryTime = _expiryTime;
        _colourSelected = _colourSelected;
        _isSelected = _isSelected;
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

  Future _getSessionInit() async {
    return _memoizer.runOnce(() async {
      if (_uuid == null) {
        _logger.d(
          "RETRIVE STATE INIT $_uuid",
        );

        SharedPreferences.getInstance().then((SharedPreferences sp) {
          SharedPreferences prefs = sp;
          _logger.d("RETRIVE STATE SP $sp");
          final keys = prefs.getKeys();

          final prefsMap = Map<String, dynamic>();
          for (String key in keys) {
            prefsMap[key] = prefs.get(key);
          }

          _logger.d("SHARED PREF $prefsMap");
          String? uuidRef = prefs.getString('uuid');
          _logger.d("RETRIVE STATE uudi is 1 $uuidRef, 2 $_uuid");
          if (uuidRef == null) {
            _databaseService.addDroplet().then((refID) {
              _logger.d("CREATE NEW UUID $refID");

              setState(() {
                _uuid = refID;
              });
              prefs.setString('uuid', _uuid);
            });
          } else {
            setState(() {
              _uuid = uuidRef;
            });
          }
          _logger.d("RETRIVE STATE AFTER uudi is $_uuid");
        });
      }
    });
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

  void onInfoNotification() async {
    showDialog(
      context: context,
      builder: (_) {
        return const AlertDialog(
          title: Text("So What is the Colour App?"),
          content: Text(
              "Every 24 hours you pick a colour. The app collects information about you, quietly, in the background. This is the same information that most other apps on your phone collect to optimize your buying patterns. In a few weeks digital compositions will appear on the app, where artists use data as random input to create dynamic, constantly evolving works of art. As new data comes in the old gets deleted, and is never used for anything else.\n\n\nTogether we are exploring our relationship with our personal data, and what ownership of personal data means in today's world. Hopefully though this project we can take some of that ownership back.\n\n\nStart picking colours, compositions will show up soon."),
        );
      },
    );
  }

  Future _showNotificationWithDefaultSound() async {
    const AndroidNotificationDetails? androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high);
    const iOSPlatformChannelSpecifics = IOSNotificationDetails();
    const platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    // await flutterLocalNotificationsPlugin.show(
    //   0,
    //   'New Post',
    //   'How to Show Notification in Flutter',
    //   platformChannelSpecifics,
    //   payload: 'Default_Sound',
    // );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Pick A Colour',
      'A New Day. A Fresh Mood. A New Colour.',
      tz.TZDateTime.now(tz.local).add(const Duration(hours: 24)),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
