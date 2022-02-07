import 'package:geolocator/geolocator.dart';
import 'package:my_app/data/models/user.dart';

class Droplet {
  final AppUser user;
  final Position position;

  const Droplet({required this.user, required this.position});
}
