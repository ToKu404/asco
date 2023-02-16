import 'package:asco/src/data/datasources/auth_datasources.dart';
import 'package:asco/src/data/datasources/profile_datasources.dart';
import 'package:asco/src/data/repositories/auth_repository_impl.dart';
import 'package:asco/src/data/repositories/profile_repository_impl.dart';
import 'package:asco/src/domain/repositories/auth_repository.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';
import 'package:asco/src/domain/usecases/auth_usecases/create_user.dart';
import 'package:asco/src/domain/usecases/auth_usecases/get_user.dart';
import 'package:asco/src/domain/usecases/auth_usecases/login.dart';
import 'package:asco/src/domain/usecases/auth_usecases/logout.dart';
import 'package:asco/src/domain/usecases/auth_usecases/remove_user.dart';
import 'package:asco/src/domain/usecases/profile_usecases/create_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/get_list_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/get_single_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/remove_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/self_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/update_profile.dart';
import 'package:asco/src/presentations/providers/auth_notifier.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
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
      removeUserUsecase: locator(),
    ),
  );

  locator.registerFactory(
    () => ProfileNotifier(
      createProfileUsecase: locator(),
      getListProfileUsecase: locator(),
      getSingleProfileUsecase: locator(),
      removeProfileUsecase: locator(),
      updateProfileUsecase: locator(),
      selfProfileUsecase: locator(),
    ),
  );

  //! repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authDataSources: locator(),
    ),
  );
  locator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      profileDataSources: locator(),
    ),
  );

  //! usecases
  //? Auth Usecase
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
  locator.registerLazySingleton(
    () => RemoveUser(
      authRepository: locator(),
    ),
  );
  //? Profile Usecase
  locator.registerLazySingleton(
    () => CreateProfile(
      profileRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetListProfile(
      profileRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetSingleProfile(
      profileRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SelfProfile(
      profileRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => RemoveProfile(
      profileRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => UpdateProfile(
      profileRepository: locator(),
    ),
  );

  //! datasources
  locator.registerLazySingleton<AuthDataSources>(
    () => AuthDataSourcesImpl(
      firestore: locator(),
      authPreferenceHelper: locator(),
    ),
  );
  locator.registerLazySingleton<ProfileDataSource>(
    () => ProfileDataSourceImpl(
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
