import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps_counter/data/datasources/firebase_accounts_datasource.dart';
import 'package:steps_counter/data/datasources/firebase_achivements_datasource.dart';
import 'package:steps_counter/data/datasources/firebase_auth_datasource.dart';
import 'package:steps_counter/data/datasources/helpers/firebase_account_datasource_helper.dart';
import 'package:steps_counter/data/repositories/firebase_account_repository.dart';
import 'package:steps_counter/data/repositories/firebase_achievements_repository.dart';
import 'package:steps_counter/data/repositories/firebase_auth_repository.dart';
import 'package:steps_counter/data/repositories/i_steps_counter_repository.dart';
import 'package:steps_counter/domain/repositories/account_repository.dart';
import 'package:steps_counter/domain/repositories/achievements_repository.dart';
import 'package:steps_counter/domain/repositories/auth_repository.dart';
import 'package:steps_counter/domain/repositories/steps_counter_repository.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  getIt.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);

  getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  getIt.registerLazySingleton<Logger>(
    () => Logger(printer: PrettyPrinter(methodCount: 10)),
  );

  getIt.registerLazySingleton<FirebaseAccountDatasourceHelper>(
    () => FirebaseAccountDatasourceHelper(
      firebaseFirestore: getIt(),
      logger: getIt(),
    ),
  );

  getIt.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSource(
      firebaseAuth: getIt(),
      firebaseAccountDatasourceHelper: getIt(),
      logger: getIt(),
    ),
  );

  getIt.registerLazySingleton<FirebaseAchievementsDataSource>(
    () => FirebaseAchievementsDataSource(
      firebaseFirestore: getIt(),
      logger: getIt(),
    ),
  );

  getIt.registerLazySingleton<FirebaseAccountsDataSource>(
    () => FirebaseAccountsDataSource(
      firebaseAccountDatasourceHelper: getIt(),
      firebaseAuth: getIt(),
    ),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => FirebaseAuthRepository(authDatasource: getIt()),
  );

  getIt.registerLazySingleton<StepsCounterRepository>(
    () => IStepsCounterRepository(
      sharedPreferences: getIt(),
    ),
  );

  getIt.registerLazySingleton<AchievementsRepository>(
    () => FirebaseAchievementsRepository(
      firebaseAchievementsDataSource: getIt(),
      sharedPreferences: getIt(),
    ),
  );

  getIt.registerLazySingleton<AccountRepository>(
    () => FirebaseAccountRepository(
      firebaseAccountsDataSource: getIt(),
    ),
  );
}
