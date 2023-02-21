import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/state/request_state.dart';
import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/domain/usecases/practicum_usecases/create_practicum.dart';
import 'package:asco/src/domain/usecases/practicum_usecases/get_list_practicum.dart';
import 'package:asco/src/domain/usecases/practicum_usecases/get_single_practicum.dart';

class PracticumNotifier extends CrudDataService<PracticumEntity> {
  final CreatePracticum createUsecase;
  final GetListPracticum getListUsecase;
  final GetSinglePracticum getSingleUsecase;

  PracticumNotifier({
    required this.createUsecase,
    required this.getListUsecase,
    required this.getSingleUsecase,
  }) {
    createState(['create', 'find', 'single']);
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