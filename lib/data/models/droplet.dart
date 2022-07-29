import 'package:my_app/data/models/user.dart';
import 'package:my_app/data/models/location.dart';

class Droplet {
  final DateTime timestamp;

  const Droplet({required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
    };
  }

  Droplet.fromMap(Map<String, dynamic> dropletMap)
      : timestamp = dropletMap["timestamp"];
}
