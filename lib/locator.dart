import 'package:get_it/get_it.dart';
import 'package:otp/db/db_services.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => HiveServices());
}
