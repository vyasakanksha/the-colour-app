import 'package:geolocator/geolocator.dart';

class TimeZone {
  final String timezone;

  TimeZone({required this.timezone});

  Map<String, dynamic> toMap() {
    return {
      'timezone': timezone,
    };
  }

  TimeZone.fromMap(Map<String, dynamic> timezoneMap)
      : timezone = timezoneMap["timezone"];
}
