import 'package:gotrue/src/user.dart';
import 'package:logger/logger.dart';
import 'package:postgrest/src/postgrest_response.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/supabase_api.dart';
import 'package:my_app/services/local_storage_service.dart';
import 'package:my_app/data/models/user.dart';

class AuthenticationService {
  final _logger = Logger();
  final _localStorageService = locator<LocalStorageService>();

  AppUser? _user;
  AppUser? get user => _user;
  bool get hasUser => _user != null;

  Future<void> initialize() async {
    _logger.d("Logger is working!");
    final accessToken = await _localStorageService.getItem('token');
    _logger.i(accessToken);

    if (accessToken == null) {
      return;
    }

    final response = await supabase.auth.api.getUser(accessToken);

    if (response.error != null) {
      return;
    }

    final user = response.data!;
    _logger.i(user.toJson());
    await fetchUser(id: user.id);
  }

  Future<AppUser?> fetchUser({required String id}) async {
    final response = await supabase
        .from("app_users")
        .select()
        .eq('id', id)
        .single()
        .execute();

    _logger.i(
      'Count: ${response.count}, Status: ${response.status}, Data: ${response.data}',
    );

    if (response.error != null) {
      _logger.e(response.error!.message);
      return null;
    }

    _logger.i(response.data);
    final data = AppUser.fromJson(response.data);
    _user = data;

    print(data);
    return data;
  }
}
