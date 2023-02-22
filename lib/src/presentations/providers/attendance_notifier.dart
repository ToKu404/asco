import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/state/request_state.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_result_entity.dart';
import 'package:asco/src/domain/entities/meeting_entities/meeting_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/usecases/attendance_usecases/add_attendance.dart';
import 'package:asco/src/domain/usecases/attendance_usecases/create_attendance.dart';
import 'package:asco/src/domain/usecases/attendance_usecases/get_list_attendance.dart';
import 'package:asco/src/domain/usecases/attendance_usecases/get_single_attendance.dart';

class AttendanceNotifier extends CrudDataService<AttendanceResultEntity> {
  final CreateAttendance createUsecase;
  final GetListAttendance getListDataUsecase;
  final GetSingleAttendance getSingleDataUsecase;
  final UpdateAttendance updateUsecase;

  AttendanceNotifier({
    required this.createUsecase,
    required this.getListDataUsecase,
    required this.getSingleDataUsecase,
    required this.updateUsecase,
  }) {
    createState(['create', 'find', 'single', 'update']);
  }

  Future<void> create(
      {required List<DetailProfileEntity> students,
      required String classroomUid,
      required MeetingEntity meeting}) async {
    updateState(state: RequestState.loading, key: 'create');
    try {
      final result = await createUsecase.execute(
        classroomUid: classroomUid,
        meeting: meeting,
        students: students,
      );
      result.fold((l) {
        updateState(state: RequestState.error, key: 'create');
        setErrorMessage(l.message);
      }, (r) {
        updateState(state: RequestState.success, key: 'create');
      });
      notifyListeners();
    } catch (e) {
      updateState(state: RequestState.error, key: 'create');
      setErrorMessage(e.toString());
    }
  }

  //* Get List
  Future<void> fetch({
    required String classroomUid,
  }) async {
    updateState(state: RequestState.loading, key: 'find');
    try {
      final result =
          await getListDataUsecase.execute(classroomUid: classroomUid);
      result.fold((l) {
        updateState(state: RequestState.error, key: 'find');
        setErrorMessage(l.message);
      }, (r) {
        updateState(state: RequestState.success, key: 'find');
        setListData(r);
      });
      notifyListeners();
    } catch (e) {
      updateState(state: RequestState.error, key: 'find');
      setErrorMessage(e.toString());
      notifyListeners();
    }
  }

  //* Get Single
  Future<void> getDetail({
    required String meetingUid,
    required String classroomUid,
  }) async {
    updateState(state: RequestState.loading, key: 'single');
    try {
      final result = await getSingleDataUsecase.execute(
        classroomUid: classroomUid,
        meetingUid: meetingUid,
      );

      result.fold((l) {
        updateState(state: RequestState.error, key: 'single');
        setErrorMessage(l.message);
      }, (r) {
        updateState(state: RequestState.success, key: 'single');
        setData(r);
      });
      notifyListeners();
    } catch (e) {
      updateState(state: RequestState.error, key: 'single');
      setErrorMessage(e.toString());
      notifyListeners();
    }
  }

  //* Update
  Future<void> updateData({
    required String uid,
    required AttendanceEntity attendance,
    required AttendanceEntity oldAttendance,
  }) async {
    updateState(state: RequestState.loading, key: 'update');
    try {
      final result = await updateUsecase.execute(
        attendance: attendance,
        oldAttendance: oldAttendance,
        uid: uid,
      );

      result.fold((l) {
        updateState(state: RequestState.error, key: 'update');
        setErrorMessage(l.message);
      }, (r) {
        updateState(state: RequestState.success, key: 'update');
      });
      notifyListeners();
    } catch (e) {
      updateState(state: RequestState.error, key: 'single');
      setErrorMessage(e.toString());
      notifyListeners();
    }
  }
}
