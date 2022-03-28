import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/services/authentication_service.dart';
import 'package:my_app/services/local_storage_service.dart';
import 'package:my_app/services/data_collection/location.dart';
import 'package:my_app/services/data_collection/user.dart';
import 'package:my_app/services/data_collection/selected_colour.dart';
import 'package:my_app/screens/home/screen.dart';

@StackedApp(
  logger: StackedLogger(),
  routes: [
    MaterialRoute(page: HomeScreen, initial: true),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: LocalStorageService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: LocationService),
    LazySingleton(classType: SelectedColourService),
  ],
)
class AppSetup {}
