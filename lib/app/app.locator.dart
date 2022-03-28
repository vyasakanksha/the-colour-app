// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/authentication_service.dart';
import '../services/data_collection/location.dart';
import '../services/data_collection/selected_colour.dart';
import '../services/data_collection/user.dart';
import '../services/local_storage_service.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => LocalStorageService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => SelectedColourService());
}
