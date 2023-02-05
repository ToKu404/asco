import 'package:asco/src/data/datasources/auth_datasources.dart';
import 'package:asco/src/data/repositories/auth_repository_impl.dart';
import 'package:asco/src/domain/repositories/auth_repository.dart';
import 'package:asco/src/domain/usecases/auth_usecases/create_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  //! state_management

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

  //! datasources
  locator.registerLazySingleton<AuthDataSources>(
    () => AuthDataSourcesImpl(
      firestore: locator(),
    ),
  );

  //! external
  final firestore = FirebaseFirestore.instance;
  locator.registerLazySingleton(() => firestore);
}
