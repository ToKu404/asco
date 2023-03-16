import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/states/request_state.dart';
import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/domain/usecases/practicum_usecases/create_practicum.dart';
import 'package:asco/src/domain/usecases/practicum_usecases/get_list_practicum.dart';
import 'package:asco/src/domain/usecases/practicum_usecases/get_single_practicum.dart';
import 'package:asco/src/domain/usecases/practicum_usecases/update_practicum_assistant.dart';

class PracticumNotifier extends CrudDataService<PracticumEntity> {
  final CreatePracticum createUsecase;
  final GetListPracticum getListUsecase;
  final GetSinglePracticum getSingleUsecase;
  final UpdatePracticumAssistant updateAssistantUsecase;

  PracticumNotifier({
    required this.createUsecase,
    required this.getListUsecase,
    required this.getSingleUsecase,
    required this.updateAssistantUsecase,
  }) {
    createState(['create', 'find', 'single', 'update_assistant']);
  }

  Future<void> create(PracticumEntity entity) async {
    updateState(state: RequestState.loading, key: 'create');
    try {
      final result = await createUsecase.execute(practicumEntity: entity);
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

  //* Update Assistant
  Future<void> updateAssistant({
    required List<ProfileEntity> assistants,
    required String practicumUid,
  }) async {
    updateState(state: RequestState.loading, key: 'update_assistant');
    try {
      final result = await updateAssistantUsecase.execute(
        assistants: assistants,
        practicumUid: practicumUid,
      );
      result.fold((l) {
        updateState(state: RequestState.error, key: 'update_assistant');
        setErrorMessage(l.message);
      }, (r) {
        updateState(state: RequestState.success, key: 'update_assistant');
      });
      notifyListeners();
    } catch (e) {
      updateState(state: RequestState.error, key: 'update_assistant');
      setErrorMessage(e.toString());
    }
  }

  //* Get List Practicum
  Future<void> fetch() async {
    updateState(state: RequestState.loading, key: 'find');
    try {
      final result = await getListUsecase.execute();
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

  //* Get List Practicum
  Future<void> getDetail({required String uid}) async {
    updateState(state: RequestState.loading, key: 'single');
    try {
      final result = await getSingleUsecase.execute(uid: uid);
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
