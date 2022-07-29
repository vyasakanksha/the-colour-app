import 'package:geolocator/geolocator.dart';

class Location {
  final Map<String, dynamic> details;
  final bool permission;

  Location({required this.permission, required this.details});

  Map<String, dynamic> toMap() {
    return {
      'details': details,
      'permission': permission,
    };
  }

  Location.fromMap(Map<String, dynamic> locationMap)
      : details = locationMap["details"],
        permission = locationMap["permission"];
}
