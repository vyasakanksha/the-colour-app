import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/data/models/droplet.dart';
import 'package:my_app/data/models/location.dart';
import 'package:my_app/data/models/selected_colour.dart';
import 'package:my_app/data/models/timezone.dart';
import 'package:my_app/data/models/device_details.dart';

import 'package:logger/logger.dart';

class DatabaseService {
  // collection reference
  final CollectionReference dropletCollection =
      FirebaseFirestore.instance.collection('droplet');

  final _logger = Logger();

  Future addDroplet() async {
    _logger.d("Add Droplet Func");
    Droplet d = Droplet(timestamp: DateTime.now());
    DocumentReference docRef = await dropletCollection.add(d.toMap());
    return docRef.id;
  }

  Future addColourData(Color colour, String uid) async {
    _logger.d("add colour, $uid $colour");
    Colour col = Colour(colour: colour, timestamp: DateTime.now());
    return await dropletCollection
        .doc(uid)
        .collection('colours')
        .add(col.toMap());
  }

  Future addLocationData(
      bool permission, Map<String, dynamic> details, String? uid) async {
    _logger.d("add locaton", uid);
    Location loc = Location(permission: permission, details: details);
    return await dropletCollection
        .doc(uid)
        .collection('location')
        .add(loc.toMap());
  }

  Future addTimeZoneData(String timezone, String? uid) async {
    _logger.d("add timezone", uid);
    TimeZone tz = TimeZone(timezone: timezone);
    return await dropletCollection
        .doc(uid)
        .collection('timezone')
        .add(tz.toMap());
  }

  Future addDeviceDetailsData(Map<String, dynamic> details, String? uid) async {
    _logger.d("device details", uid);
    DeviceDetails dd = DeviceDetails(details: details);
    return await dropletCollection
        .doc(uid)
        .collection('device')
        .add(dd.toMap());
  }
}
