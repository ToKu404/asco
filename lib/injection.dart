import 'package:asco/src/data/datasources/auth_datasources.dart';
import 'package:asco/src/data/repositories/auth_repository_impl.dart';
import 'package:asco/src/domain/repositories/auth_repository.dart';
import 'package:asco/src/domain/usecases/auth_usecases/create_user.dart';
import 'package:asco/src/domain/usecases/auth_usecases/get_user.dart';
import 'package:asco/src/domain/usecases/auth_usecases/login.dart';
import 'package:asco/src/domain/usecases/auth_usecases/logout.dart';
import 'package:asco/src/presentations/providers/auth_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import 'src/data/services/preferences_services.dart';

final locator = GetIt.instance;

void init() {
  //! state_management
  locator.registerFactory(
    () => AuthNotifier(
      createUserUsecase: locator(),
      loginUsecase: locator(),
      getUserUsecase: locator(),
      logoutUsecase: locator(),
    ),
  );

  //! repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authDataSources: locator(),
    ),
  );

  //! usecases
  locator.registerLazySingleton(
    () => CreateUser(
      authRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => Login(
      authRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => LogOut(
      authRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetUser(
      authRepository: locator(),
    ),
  );

  //! datasources
  locator.registerLazySingleton<AuthDataSources>(
    () => AuthDataSourcesImpl(
      firestore: locator(),
      authPreferenceHelper: locator(),
    ),
  );

  //! external
  final firestore = FirebaseFirestore.instance;
  locator.registerLazySingleton(() => firestore);
  locator.registerLazySingleton<AuthPreferenceHelper>(
      () => AuthPreferenceHelper());
}
