                //Here we'd start to use dependences pattenrs to organize our system and make the structure
                                  //more clean and in another words mare readible.
import 'package:financial_app_project/features/sign_in/sign_in_controller.dart';

import 'package:financial_app_project/features/sign_up/sign_up_controller.dart';
import 'package:financial_app_project/features/splash/splash_controller.dart';
import 'package:financial_app_project/services/auth_service/auth_service.dart';
import 'package:financial_app_project/services/auth_service/firebase_auth_service.dart';
import 'package:financial_app_project/services/secure_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<AuthService>(() => FirebaseAuthService());

  locator.registerFactory<SplashController>(
    () => SplashController(const SecureStorage()),
  );

  locator.registerFactory<SignInController>(
    () => SignInController(service: locator.get<AuthService>()),
  );

  locator.registerFactory<SignUpController>(
    () => SignUpController(locator.get<AuthService>(), const SecureStorage()),
  );
}