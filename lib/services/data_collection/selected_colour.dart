import 'package:my_app/data/models/selected_colour.dart';
import 'package:postgrest/postgrest.dart';
import 'package:my_app/app/supabase_api.dart';
import 'package:my_app/services/supabase_service.dart';
import 'package:my_app/data/models/location.dart';
import 'package:my_app/data/models/user.dart';
import 'package:logger/logger.dart';

import 'package:supabase/supabase.dart';

class SelectedColourService extends SupabaseService<Location> {
  final _logger = Logger();

  @override
  String tableName() {
    return "colour";
  }

  Future<PostgrestResponse> addselectedcolour(
      {required String id, required SelectedColour col}) async {
    return await supabase
        .from("colour")
        .insert(SelectedColour(id: id, colour: col.colour).toJson())
        .execute();
  }

  Future<void> createColour(id, colour) async {
    final response = await create(
      SelectedColour(
              id: id,
              colour: (colour.value & 0xFFFFFF)
                  .toRadixString(16)
                  .padLeft(6, '0')
                  .toUpperCase())
          .toJson(),
    );

    if (response.error != null) {
      _logger.e(response.error!.message);
      return;
    }
  }
}
