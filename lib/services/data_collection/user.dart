import 'package:postgrest/postgrest.dart';
import 'package:my_app/app/supabase_api.dart';
import 'package:my_app/services/supabase_service.dart';
import 'package:my_app/data/models/location.dart';
import 'package:my_app/data/models/user.dart';
import 'package:logger/logger.dart';

import 'package:supabase/supabase.dart';

class UserService extends SupabaseService<Location> {
  final _logger = Logger();

  @override
  String tableName() {
    return "users";
  }

  Future<PostgrestResponse> addusersession(
      {required String id, required AppUser userSessionData}) async {
    return await supabase
        .from("users")
        .insert(AppUser(
                id: id,
                timeIn: userSessionData.timeIn,
                timeOut: userSessionData.timeOut)
            .toJson())
        .execute();
  }
}
