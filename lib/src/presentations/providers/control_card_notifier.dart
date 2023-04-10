import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/states/request_state.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_entities.dart';
import 'package:asco/src/domain/usecases/control_card_usecases/init_student_control_card.dart';
import 'package:asco/src/domain/usecases/control_card_usecases/get_list_control_card.dart';
import 'package:asco/src/domain/usecases/control_card_usecases/get_single_control_card.dart';

class ControlCardNotifier extends CrudDataService<ControlCardEntity> {
  final InitStudentControlCard createUsecase;
  final GetSingleControlCard getSingleDataUsecase;
  final GetListControlCard getListDataUsecase;

  ControlCardNotifier({
    required this.createUsecase,
    required this.getSingleDataUsecase,
    required this.getListDataUsecase,
  }) {
    createState(['create', 'single', 'find']);
  }

  Future<void> initStudent({
    required String practicumUid,
    required List<String>? addedStudentId,
    required List<String>? removeStudentId,
  }) async {
    updateState(state: RequestState.loading, key: 'create');

    final result = await createUsecase.execute(
      practicumUid: practicumUid,
      addedStudentId: addedStudentId,
      removeStudentId: removeStudentId,
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

  Future<void> getDetail({required String uuid}) async {
    updateState(state: RequestState.loading, key: 'single');

    final result = await getSingleDataUsecase.execute(
      uuid: uuid,
    );

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

  Future<void> fetch({required String studentId}) async {
    updateState(state: RequestState.loading, key: 'find');

    final result = await getListDataUsecase.execute(id: studentId);

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
}
