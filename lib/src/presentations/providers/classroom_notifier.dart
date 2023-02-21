import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/state/request_state.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/domain/usecases/classroom_usecases/create_practicum.dart';
import 'package:asco/src/domain/usecases/classroom_usecases/get_list_practicum.dart';
import 'package:asco/src/domain/usecases/classroom_usecases/get_single_practicum.dart';

class ClassroomNotifier extends CrudDataService<ClassroomEntity> {
  final CreateClassroom createUsecase;
  final GetListClassroom getListDataUsecase;
  final GetSingleClassroom getSingleDataUsecase;

  ClassroomNotifier({
    required this.createUsecase,
    required this.getListDataUsecase,
    required this.getSingleDataUsecase,
  }) {
    createState(['create', 'find', 'single']);
  }

  Future<void> create(
      {required ClassroomEntity entity, required String practicumUid}) async {
    updateState(state: RequestState.loading, key: 'create');
    try {
      final result = await createUsecase.execute(
        entity: entity,
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
}
