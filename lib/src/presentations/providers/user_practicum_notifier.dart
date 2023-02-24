// import 'package:asco/core/services/data_service.dart';
// import 'package:asco/core/state/request_state.dart';
// import 'package:asco/src/domain/entities/user_practicum_entities/user_practicum_entity.dart';
// import 'package:asco/src/domain/usecases/user_practicums_usecases/get_list_user_practicum.dart';
// import 'package:asco/src/domain/usecases/user_practicums_usecases/set_user_practicum.dart';

// class UserPracticumNotifier extends CrudDataService<UserPracticumEntity> {
//   final SetUserPracticum setUsecase;
//   final GetListUserPracticum getListUsecase;

//   UserPracticumNotifier({
//     required this.getListUsecase,
//     required this.setUsecase,
//   }) {
//     createState([
//       'set',
//       'find',
//     ]);
//   }

//   Future<void> set(
//       {required UserPracticumEntity userPracticum,
//       required List<String> listStudentId}) async {
//     updateState(state: RequestState.loading, key: 'set');
//     notifyListeners();
//     try {
//       final result = await setUsecase.execute(
//           userPracticum: userPracticum, listStudentId: listStudentId);
//       result.fold((l) {
//         updateState(state: RequestState.error, key: 'set');
//         setErrorMessage(l.message);
//       }, (r) {
//         updateState(state: RequestState.success, key: 'set');
//       });
//       notifyListeners();
//     } catch (e) {
//       updateState(state: RequestState.error, key: 'set');
//       setErrorMessage(e.toString());
//       notifyListeners();
//     }
//   }

//   Future<void> fetch({
//     String? classroomUid,
//     String? groupUid,
//     String? practicumUid,
//   }) async {
//     updateState(state: RequestState.loading, key: 'find');
//     try {
//       final result = await getListUsecase.execute(
//         classroomUid: classroomUid,
//         groupUid: groupUid,
//         practicumUid: practicumUid,
//       );
//       result.fold((l) {
//         updateState(state: RequestState.error, key: 'find');
//         setErrorMessage(l.message);
//       }, (r) {
//         updateState(state: RequestState.success, key: 'find');
//         setListData(r);
//       });
//       notifyListeners();
//     } catch (e) {
//       updateState(state: RequestState.error, key: 'find');
//       setErrorMessage(e.toString());
//       notifyListeners();
//     }
//   }
// }
