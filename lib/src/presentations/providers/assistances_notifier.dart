import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/state/request_state.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/domain/usecases/assistance_usecases/create_assistance_group.dart';
import 'package:asco/src/domain/usecases/assistance_usecases/get_list_assistance_group.dart';
import 'package:asco/src/domain/usecases/assistance_usecases/get_single_assistance_group.dart';
import 'package:asco/src/domain/usecases/assistance_usecases/update_student_assistance_group.dart';

class AssistancesNotifier extends CrudDataService<AssistanceGroupEntity> {
  final CreateAssistanceGroup createUsecase;
  final GetListAssistanceGroup getListDataUsecase;
  final GetSingleAssistanceGroup getSingleDataUsecase;
  final UpdateStudentAssistanceGroup updateStudentUsecase;

  AssistancesNotifier({
    required this.createUsecase,
    required this.getListDataUsecase,
    required this.getSingleDataUsecase,
    required this.updateStudentUsecase,
  }) {
    createState(['create', 'find', 'single', 'update_student']);
  }

  //* Create
  Future<void> create({
    required AssistanceGroupEntity entity,
  }) async {
    updateState(state: RequestState.loading, key: 'create');
    try {
      final result = await createUsecase.execute(
        entity: entity,
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
    required String practicumUid,
  }) async {
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

  //* Get Single
  Future<void> getDetail({required String uuid, String? assistant}) async {
    updateState(state: RequestState.loading, key: 'single');
    try {
      final result =
          await getSingleDataUsecase.execute(uuid: uuid, assistant: assistant);
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
      required String assistanceGroupUid}) async {
    updateState(state: RequestState.loading, key: 'update_student');
    try {
      final result = await updateStudentUsecase.execute(
        students: students,
        assistanceGroupUid: assistanceGroupUid,
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
