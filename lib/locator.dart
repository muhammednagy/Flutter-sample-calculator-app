import 'package:nagy_calc/services/api/CRUDModel.dart';
import 'package:nagy_calc/services/api/api.dart';
import 'package:get_it/get_it.dart';
GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => Api('calculations'));
  locator.registerLazySingleton(() => CRUDModel()) ;
}