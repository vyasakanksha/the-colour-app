import 'package:postgrest/postgrest.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/supabase_api.dart';
import 'package:my_app/services/authentication_service.dart';
import 'package:my_app/services/supabase_service.dart';
import 'package:my_app/data/models/location.dart';

import '../authentication_service.dart';

class LocationService extends SupabaseService<Location> {
  final _authService = locator<AuthenticationService>();
}
