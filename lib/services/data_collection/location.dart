import 'package:postgrest/postgrest.dart';
import 'package:my_app/app/supabase_api.dart';
import 'package:my_app/services/supabase_service.dart';
import 'package:logger/logger.dart';

import 'package:my_app/data/models/location.dart';

class LocationService extends SupabaseService<Location> {
  final _logger = Logger();

  @override
  String tableName() {
    return "location";
  }

  Future<PostgrestResponse> addlocation(
      {required String id, required Location locationData}) async {
    return await supabase
        .from("location")
        .insert(Location(
                id: id,
                permission: locationData.permission,
                timeIn: locationData.timeIn,
                timeOut: locationData.timeOut,
                details: locationData.details)
            .toJson())
        .execute();
  }

  Future<void> createLocation(id, _permission, _details) async {
    final response = await create(
      Location(
              id: id,
              timeIn: DateTime.now(),
              timeOut: DateTime.now(),
              permission: _permission,
              details: _details.cast<String, dynamic>())
          .toJson(),
    );

    if (response.error != null) {
      _logger.e(response.error!.message);
      return;
    }
  }
}
