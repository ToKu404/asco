import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:asco/core/services/preference_service.dart';
import 'package:asco/src/data/datasources/datasources.dart';
import 'package:asco/src/data/repositories/repositories.dart';
import 'package:asco/src/domain/repositories/repositories.dart';
import 'package:asco/src/domain/usecases/usecases.dart';
import 'package:asco/src/presentations/providers/assistance_notifier.dart';
import 'package:asco/src/presentations/providers/auth_notifier.dart';
import 'package:asco/src/presentations/providers/classroom_notifier.dart';
import 'package:asco/src/presentations/providers/meeting_notifier.dart';
import 'package:asco/src/presentations/providers/practicum_notifier.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';

final locator = GetIt.instance;

void init() {
  //! state_management
  locator.registerFactory(
    () => AuthNotifier(
      createUsecase: locator(),
      loginUsecase: locator(),
      singleUsecase: locator(),
      logoutUsecase: locator(),
      removeUserUsecase: locator(),
    ),
  );

  locator.registerFactory(
    () => ProfileNotifier(
      createUsecase: locator(),
      getListDataUsecase: locator(),
      getSingleUsecase: locator(),
      removeDataUsecase: locator(),
      updateDataUsecase: locator(),
      selfDataUsecase: locator(),
      getMultipleUsecase: locator(),
      updateMultiplePracticumsUsecase: locator(),
    ),
  );

  locator.registerFactory(
    () => PracticumNotifier(
      createUsecase: locator(),
      getListUsecase: locator(),
      getSingleUsecase: locator(),
      updateAssistantUsecase: locator(),
    ),
  );

  locator.registerFactory(
    () => ClassroomNotifier(
      createUsecase: locator(),
      getListDataUsecase: locator(),
      getSingleDataUsecase: locator(),
      updateStudentUsecase: locator(),
    ),
  );

  locator.registerFactory(
    () => MeetingNotifier(
      createUsecase: locator(),
      getListDataUsecase: locator(),
      getSingleDataUsecase: locator(),
    ),
  );

  locator.registerFactory(
    () => AssistanceNotifier(
      createUsecase: locator(),
      getListDataUsecase: locator(),
      getSingleDataUsecase: locator(),
      updateStudentUsecase: locator(),
    ),
  );

  //! repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      datasource: locator(),
    ),
  );
  locator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      datasource: locator(),
    ),
  );
  locator.registerLazySingleton<PracticumRepository>(
    () => PracticumRepositoryImpl(
      datasource: locator(),
    ),
  );
  locator.registerLazySingleton<ClassroomRepository>(
    () => ClassroomRepositoryImpl(
      datasource: locator(),
    ),
  );
  locator.registerLazySingleton<MeetingRepository>(
    () => MeetingRepositoryImpl(
      datasource: locator(),
    ),
  );

  locator.registerLazySingleton<AssistanceGroupRepository>(
    () => AssistanceGroupRepositoryImpl(
      datasource: locator(),
    ),
  );

  //! usecases
  //? Auth Usecase
  locator.registerLazySingleton(
    () => CreateUser(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => LogIn(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => LogOut(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetUser(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => RemoveUser(
      repository: locator(),
    ),
  );
  //? Profile Usecase
  locator.registerLazySingleton(
    () => CreateProfile(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetListProfile(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetMultipleProfile(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetSingleProfile(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SelfProfile(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => RemoveProfile(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => UpdateProfile(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => UpdateMultiplePracticums(
      repository: locator(),
    ),
  );
  //* Practicum Usecase
  locator.registerLazySingleton(
    () => CreatePracticum(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetListPracticum(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetSinglePracticum(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => UpdatePracticumAssistant(
      repository: locator(),
    ),
  );
  //* ClassroomUsecase
  locator.registerLazySingleton(
    () => CreateClassroom(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetListClassroom(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetSingleClassroom(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => UpdateStudentClassroom(
      repository: locator(),
    ),
  );

  //* Meeting Usecase
  locator.registerLazySingleton(
    () => CreateMeeting(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetListMeeting(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetSingleMeeting(
      repository: locator(),
    ),
  );

  //* Meeting Usecase
  locator.registerLazySingleton(
    () => CreateAssistanceGroup(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetListAssistanceGroup(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetSingleAssistanceGroup(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => UpdateStudentAssistanceGroup(
      repository: locator(),
    ),
  );

  //! datasources
  locator.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(
      firestore: locator(),
      pref: locator(),
    ),
  );
  locator.registerLazySingleton<ProfileDataSource>(
    () => ProfileDataSourceImpl(
      firestore: locator(),
      pref: locator(),
    ),
  );
  locator.registerLazySingleton<PracticumDataSource>(
    () => PracticumDataSourceImpl(
      firestore: locator(),
    ),
  );
  locator.registerLazySingleton<ClassroomDataSource>(
    () => ClassroomDataSourceImpl(
      firestore: locator(),
    ),
  );
  locator.registerLazySingleton<MeetingDataSource>(
    () => MeetingDataSourceImpl(
      firestore: locator(),
      profileDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<AssistanceGroupDataSource>(
    () => AssistanceGroupDataSourceImpl(
      firestore: locator(),
    ),
  );

  //! external
  final firestore = FirebaseFirestore.instance;
  locator.registerLazySingleton(() => firestore);
  locator.registerLazySingleton<AuthPreferenceHelper>(
      () => AuthPreferenceHelper());
}
