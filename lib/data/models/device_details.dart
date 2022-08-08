import 'package:geolocator/geolocator.dart';

class DeviceDetails {
  final Map<String, dynamic> details;

  DeviceDetails({required this.details});

  Map<String, dynamic> toMap() {
    return {
      'details': details,
    };
  }

  DeviceDetails.fromMap(Map<String, dynamic> deviceDetailsMap)
      : details = deviceDetailsMap["details"];
}
