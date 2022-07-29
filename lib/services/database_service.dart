import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/data/models/droplet.dart';
import 'package:my_app/data/models/location.dart';
import 'package:my_app/data/models/selected_colour.dart';
import 'package:geolocator/geolocator.dart';
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
    Colour col = Colour(colour: colour, timestamp: DateTime.now());
    return await dropletCollection
        .doc(uid)
        .collection('colours')
        .add(col.toMap());
  }

  Future addLocationData(
      bool permission, Map<String, dynamic> details, String uid) async {
    Location loc = Location(permission: permission, details: details);
    return await dropletCollection
        .doc(uid)
        .collection('location')
        .add(loc.toMap());
  }
}
