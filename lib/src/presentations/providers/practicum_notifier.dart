import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/state/request_state.dart';
import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/domain/usecases/practicum_usecases/create_practicum.dart';
import 'package:asco/src/domain/usecases/practicum_usecases/get_list_practicum.dart';
import 'package:asco/src/domain/usecases/practicum_usecases/get_single_practicum.dart';

class PracticumNotifier extends CrudDataService<PracticumEntity> {
  final CreatePracticum createPracticumUsecase;
  final GetListPracticum getListPracticumUsecase;
  final GetSinglePracticum getSinglePracticumUsecase;

  PracticumNotifier({
    required this.createPracticumUsecase,
    required this.getListPracticumUsecase,
    required this.getSinglePracticumUsecase,
  }) {
    createState(['create']);
  }

  Future<void> create(PracticumEntity entity) async {
    updateState(state: RequestState.loading, key: 'create');
    try {
      final result =
          await createPracticumUsecase.execute(practicumEntity: entity);
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
}
