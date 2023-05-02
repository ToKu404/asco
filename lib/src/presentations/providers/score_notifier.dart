import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/states/request_state.dart';
import 'package:asco/src/domain/entities/entities.dart';
import 'package:asco/src/domain/usecases/score_usecases/get_multiple_score.dart';
import 'package:asco/src/domain/usecases/score_usecases/update_score.dart';

class ScoreNotifier extends CrudDataService<ScoreEntity> {
  final GetMultipleScore getMultipleScore;
  final UpdateScore updateScore;

  ScoreNotifier({
    required this.getMultipleScore,
    required this.updateScore,
  }) {
    createState(['multiple', 'update']);
  }

  Future<void> fetchMultiple({required List<String> listStudentId}) async {
    updateState(state: RequestState.loading, key: 'multiple');

    final result = await getMultipleScore.execute(listId: listStudentId);

    result.fold(
      (l) {
        updateState(state: RequestState.error, key: 'multiple');

        setErrorMessage(l.message);
      },
      (r) {
        updateState(state: RequestState.success, key: 'multiple');

        setListData(r);
      },
    );
  }

  Future<void> update({
    required String uid,
    required ScoreEntity score,
  }) async {
    updateState(state: RequestState.loading, key: 'update');

    final result = await updateScore.execute(
      uid: uid,
      newScore: score,
    );

    result.fold(
      (l) {
        updateState(state: RequestState.error, key: 'update');

        setErrorMessage(l.message);
      },
      (r) {
        updateState(state: RequestState.success, key: 'update');
      },
    );
  }
}
