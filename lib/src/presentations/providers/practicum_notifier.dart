import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/states/request_state.dart';
import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/domain/usecases/practicum_usecases/practicum_usecases.dart';

class PracticumNotifier extends CrudDataService<PracticumEntity> {
  final CreatePracticum createUsecase;
  final GetSinglePracticum getSingleUsecase;
  final GetListPracticum getListUsecase;
  final UpdatePracticumAssistant updateAssistantUsecase;

  PracticumNotifier({
    required this.createUsecase,
    required this.getSingleUsecase,
    required this.getListUsecase,
    required this.updateAssistantUsecase,
  }) {
    createState(['create', 'single', 'find', 'update_assistant']);
  }

  /// Create practicum
  Future<void> create(PracticumEntity entity) async {
    updateState(state: RequestState.loading, key: 'create');

    final result = await createUsecase.execute(practicumEntity: entity);

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

  /// Get detail practicum
  Future<void> getDetail({required String uid}) async {
    updateState(state: RequestState.loading, key: 'single');

    final result = await getSingleUsecase.execute(uid: uid);

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

  /// Get list practicums
  Future<void> fetch() async {
    updateState(state: RequestState.loading, key: 'find');

    final result = await getListUsecase.execute();

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

  /// Update assistant
  Future<void> updateAssistant({
    required String practicumUid,
    required List<ProfileEntity> assistants,
  }) async {
    updateState(state: RequestState.loading, key: 'update_assistant');

    final result = await updateAssistantUsecase.execute(
      practicumUid: practicumUid,
      assistants: assistants,
    );

    result.fold(
      (l) {
        updateState(state: RequestState.error, key: 'update_assistant');

        setErrorMessage(l.message);
      },
      (r) {
        updateState(state: RequestState.success, key: 'update_assistant');
      },
    );
  }
}
