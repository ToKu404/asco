import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import 'package:asco/src/data/datasources/assistance_group_datasource.dart';
import 'package:asco/src/data/datasources/auth_datasource.dart';
import 'package:asco/src/data/datasources/classroom_datasource.dart';
import 'package:asco/src/data/datasources/meeting_datasource.dart';
import 'package:asco/src/data/datasources/practicum_datasources.dart';
import 'package:asco/src/data/datasources/profile_datasources.dart';
import 'package:asco/src/data/repositories/assistance_group_repository_impl.dart';
import 'package:asco/src/data/repositories/auth_repository_impl.dart';
import 'package:asco/src/data/repositories/classroom_repository_impl.dart';
import 'package:asco/src/data/repositories/meeting_repository_impl.dart';
import 'package:asco/src/data/repositories/practicum_repository_impl.dart';
import 'package:asco/src/data/repositories/profile_repository_impl.dart';
import 'package:asco/src/domain/repositories/assistance_repository.dart';
import 'package:asco/src/domain/repositories/auth_repository.dart';
import 'package:asco/src/domain/repositories/classroom_repository.dart';
import 'package:asco/src/domain/repositories/meeting_repository.dart';
import 'package:asco/src/domain/repositories/practicum_repository.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';
import 'package:asco/src/domain/usecases/assistance_usecases/create_assistance_group.dart';
import 'package:asco/src/domain/usecases/assistance_usecases/get_list_assistance_group.dart';
import 'package:asco/src/domain/usecases/assistance_usecases/get_single_assistance_group.dart';
import 'package:asco/src/domain/usecases/assistance_usecases/update_student_assistance_group.dart';
import 'package:asco/src/domain/usecases/auth_usecases/create_user.dart';
import 'package:asco/src/domain/usecases/auth_usecases/get_user.dart';
import 'package:asco/src/domain/usecases/auth_usecases/login.dart';
import 'package:asco/src/domain/usecases/auth_usecases/logout.dart';
import 'package:asco/src/domain/usecases/auth_usecases/remove_user.dart';
import 'package:asco/src/domain/usecases/classroom_usecases/create_classroom.dart';
import 'package:asco/src/domain/usecases/classroom_usecases/get_list_classroom.dart';
import 'package:asco/src/domain/usecases/classroom_usecases/get_single_classroom.dart';
import 'package:asco/src/domain/usecases/classroom_usecases/update_student_classroom.dart';
import 'package:asco/src/domain/usecases/meeting_usecases/create_meeting.dart';
import 'package:asco/src/domain/usecases/meeting_usecases/get_list_meeting.dart';
import 'package:asco/src/domain/usecases/meeting_usecases/get_single_meeting.dart';
import 'package:asco/src/domain/usecases/practicum_usecases/create_practicum.dart';
import 'package:asco/src/domain/usecases/practicum_usecases/get_list_practicum.dart';
import 'package:asco/src/domain/usecases/practicum_usecases/get_single_practicum.dart';
import 'package:asco/src/domain/usecases/practicum_usecases/update_practicum_assistant.dart';
import 'package:asco/src/domain/usecases/profile_usecases/create_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/get_list_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/get_multiple_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/get_single_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/multiple_practicum_update.dart';
import 'package:asco/src/domain/usecases/profile_usecases/remove_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/self_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/update_profile.dart';
import 'package:asco/src/presentations/providers/assistances_notifier.dart';
import 'package:asco/src/presentations/providers/auth_notifier.dart';
import 'package:asco/src/presentations/providers/classroom_notifier.dart';
import 'package:asco/src/presentations/providers/meeting_notifier.dart';
import 'package:asco/src/presentations/providers/practicum_notifier.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';

import 'core/services/preference_service.dart';

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
      multiplePracticumUpdateUsecase: locator(),
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
    () => AssistancesNotifier(
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
    () => Login(
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
    () => MultiplePracticumUpdate(
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
