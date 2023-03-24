import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/states/request_state.dart';
import 'package:asco/src/domain/entities/entities.dart';
import 'package:asco/src/domain/usecases/classroom_usecases/classroom_usecases.dart';

class ClassroomNotifier extends CrudDataService<ClassroomEntity> {
  final CreateClassroom createUsecase;
  final GetSingleClassroom getSingleDataUsecase;
  final GetListClassroom getListDataUsecase;
  final UpdateStudentClassroom updateStudentUsecase;

  ClassroomNotifier({
    required this.createUsecase,
    required this.getSingleDataUsecase,
    required this.getListDataUsecase,
    required this.updateStudentUsecase,
  }) {
    createState(['create', 'single', 'find', 'update_student']);
  }

  Future<void> create({
    required ClassroomEntity entity,
    required PracticumEntity? practicum,
  }) async {
    updateState(state: RequestState.loading, key: 'create');

    final result = await createUsecase.execute(
      classroom: entity,
      practicum: practicum,
    );

    result.fold(
      (l) {
        updateState(state: RequestState.error, key: 'create');

        setErrorMessage(l.message);
      },
      (r) {
        updateState(state: RequestState.success, key: 'create');
      },
    );
  }

  Future<void> getDetail({required String uid}) async {
    updateState(state: RequestState.loading, key: 'single');

    final result = await getSingleDataUsecase.execute(uid: uid);

    result.fold(
      (l) {
        updateState(state: RequestState.error, key: 'single');

        setErrorMessage(l.message);
      },
      (r) {
        updateState(state: RequestState.success, key: 'single');

        setData(r);
      },
    );
  }

  Future<void> fetch({String? practicumUid}) async {
    updateState(state: RequestState.loading, key: 'find');

    final result = await getListDataUsecase.execute(practicumUid: practicumUid);

    result.fold(
      (l) {
        updateState(state: RequestState.error, key: 'find');

        setErrorMessage(l.message);
      },
      (r) {
        updateState(state: RequestState.success, key: 'find');

        setListData(r);
      },
    );
  }

  Future<void> updateStudent({
    required String classroomUid,
    required List<ProfileEntity> students,
  }) async {
    updateState(state: RequestState.loading, key: 'update_student');

    final result = await updateStudentUsecase.execute(
      classroomUid: classroomUid,
      students: students,
    );

    result.fold(
      (l) {
        updateState(state: RequestState.error, key: 'update_student');

        setErrorMessage(l.message);
      },
      (r) {
        updateState(state: RequestState.success, key: 'update_student');
      },
    );
  }
}
