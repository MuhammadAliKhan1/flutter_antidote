import 'package:get_it/get_it.dart';
import 'navigation_service.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}