import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/states/request_state.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/domain/usecases/classroom_usecases/update_student_classroom.dart';
import 'package:asco/src/domain/usecases/classroom_usecases/create_classroom.dart';
import 'package:asco/src/domain/usecases/classroom_usecases/get_list_classroom.dart';
import 'package:asco/src/domain/usecases/classroom_usecases/get_single_classroom.dart';

class ClassroomNotifier extends CrudDataService<ClassroomEntity> {
  final CreateClassroom createUsecase;
  final GetListClassroom getListDataUsecase;
  final GetSingleClassroom getSingleDataUsecase;
  final UpdateStudentClassroom updateStudentUsecase;

  ClassroomNotifier({
    required this.createUsecase,
    required this.getListDataUsecase,
    required this.getSingleDataUsecase,
    required this.updateStudentUsecase,
  }) {
    createState(['create', 'find', 'single', 'update_student']);
  }

  Future<void> create(
      {required ClassroomEntity entity, required String practicumUid}) async {
    updateState(state: RequestState.loading, key: 'create');
    try {
      final result = await createUsecase.execute(
        classroom: entity,
        practicumUid: practicumUid,
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

  //* Get List Classroom
  Future<void> fetch({String? practicumUid}) async {
    updateState(state: RequestState.loading, key: 'find');
    try {
      final result =
          await getListDataUsecase.execute(practicumUid: practicumUid);
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

  //* Get List Classroom
  Future<void> getDetail({required String uid}) async {
    updateState(state: RequestState.loading, key: 'single');
    try {
      final result = await getSingleDataUsecase.execute(uid: uid);
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

  Future<void> updateStudent(
      {required List<ProfileEntity> students,
      required String classroomUid}) async {
    updateState(state: RequestState.loading, key: 'update_student');
    try {
      final result = await updateStudentUsecase.execute(
        students: students,
        classroomUid: classroomUid,
      );
      result.fold((l) {
        updateState(state: RequestState.error, key: 'update_student');
        setErrorMessage(l.message);
      }, (r) {
        updateState(state: RequestState.success, key: 'update_student');
      });
      notifyListeners();
    } catch (e) {
      updateState(state: RequestState.error, key: 'update_student');
      setErrorMessage(e.toString());
    }
  }
}
