import 'package:get_it/get_it.dart';
import 'package:howzatt/services/UserDataServcie.dart';


final getIt = GetIt.instance;


setupServiceLocator() {
  // Register UserDataService
  getIt.registerLazySingleton<UserDataService>(() => UserDataService());
}