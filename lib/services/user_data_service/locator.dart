import 'package:cloud_functions/cloud_functions.dart';
import 'package:financial_app_project/common/widgets/home_controller.dart';
import 'package:financial_app_project/features/balance/balance_controller.dart';
import 'package:financial_app_project/features/forgot_password/forgot_password_controller.dart';
import 'package:financial_app_project/features/home/transaction/transaction_controller.dart';
import 'package:financial_app_project/features/home/wallet/wallet_controller.dart';
import 'package:financial_app_project/features/profile/profile_controller.dart';
import 'package:financial_app_project/features/sign_in/sign_in_controller.dart';

import 'package:financial_app_project/features/sign_up/sign_up_controller.dart';
import 'package:financial_app_project/features/splash/splash_controller.dart';
import 'package:financial_app_project/features/stats/stats_controller.dart';
import 'package:financial_app_project/repositories/transaction_repository.dart';
import 'package:financial_app_project/repositories/transaction_repository_impl.dart';
import 'package:financial_app_project/services/auth_service/auth_service.dart';
import 'package:financial_app_project/services/data_service/database_service.dart';
import 'package:financial_app_project/services/auth_service/firebase_auth_service.dart';
import 'package:financial_app_project/services/data_service/graphql_service.dart';
import 'package:financial_app_project/services/secure_storage.dart';
import 'package:financial_app_project/services/sync_service/sync_controller.dart';
import 'package:financial_app_project/services/sync_service/sync_service.dart';
import 'package:financial_app_project/services/user_data_service/connection_service.dart';
import 'package:financial_app_project/services/user_data_service/user_data_service.dart';
import 'package:financial_app_project/services/user_data_service/user_data_service_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';


final locator = GetIt.instance;

void setupDependencies() {
  //Register Services
  locator.registerFactory<AuthService>(
    () => FirebaseAuthService(),
  );

  locator.registerFactory<SecureStorage>(
      () => const SecureStorage());

  locator.registerFactory<ConnectionService>(() => const ConnectionService());

  locator.registerSingletonAsync<GraphQLService>(
    () async => GraphQLService(
      authService: locator.get<AuthService>(),
    ).init(),
  );

  locator.registerSingletonAsync<DatabaseService>(
    () async => DatabaseService().init(),
  );

  locator.registerFactory<SyncService>(
    () => SyncService(
      connectionService: locator.get<ConnectionService>(),
      databaseService: locator.get<DatabaseService>(),
      graphQLService: locator.get<GraphQLService>(),
      secureStorageService: locator.get<SecureStorage>(),
    ),
  );

  locator.registerFactory<UserDataService>(() => UserDataServiceImpl(
        firebaseAuth: FirebaseAuth.instance,
        firebaseFunctions: FirebaseFunctions.instance,
      ));

  //Register Repositories

  locator.registerFactory<TransactionRepository>(
    () => TransactionRepositoryImpl(
      databaseService: locator.get<DatabaseService>(),
      syncService: locator.get<SyncService>(),
    ),
  );

  //Register Controllers

  locator.registerFactory<SplashController>(
    () => SplashController(
      secureStorage: locator.get<SecureStorage>(),
    ),
  );

  locator.registerFactory<SignInController>(
    () => SignInController(
      authService: locator.get<AuthService>(),
      secureStorageService: locator.get<SecureStorage>(),
    ),
  );

  locator.registerFactory<SignUpController>(
    () => SignUpController(
      authService: locator.get<AuthService>(),
      secureStorageService: locator.get<SecureStorage>(),
    ),
  );

  locator.registerFactory<ForgotPasswordController>(
    () => ForgotPasswordController(authService: locator.get<AuthService>()),
  );

  locator.registerLazySingleton<HomeController>(
    () => HomeController(
      transactionRepository: locator.get<TransactionRepository>(),
      userDataService: locator.get<UserDataService>(),
    ),
  );

  locator.registerLazySingleton<WalletController>(
    () => WalletController(
      transactionRepository: locator.get<TransactionRepository>(),
    ),
  );

  locator.registerLazySingleton<BalanceController>(
    () => BalanceController(
      transactionRepository: locator.get<TransactionRepository>(),
    ),
  );

  locator.registerLazySingleton<TransactionController>(
    () => TransactionController(
      transactionRepository: locator.get<TransactionRepository>(),
      secureStorageService: locator.get<SecureStorage>(),
    ),
  );

  locator.registerFactory<SyncController>(
    () => SyncController(
      syncService: locator.get<SyncService>(),
    ),
  );

  locator.registerFactory<ProfileController>(
      () => ProfileController(userDataService: locator.get<UserDataService>()));

  locator.registerLazySingleton<StatsController>(() => StatsController(
      transactionRepository: locator.get<TransactionRepository>()));
}