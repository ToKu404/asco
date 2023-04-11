import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/states/request_state.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:asco/src/domain/usecases/meeting_usecases/meeting_usecases.dart';

class MeetingNotifier extends CrudDataService<DetailMeetingEntity> {
  final CreateMeeting createUsecase;
  final GetSingleMeeting getSingleDataUsecase;
  final GetListMeeting getListDataUsecase;

  MeetingNotifier({
    required this.createUsecase,
    required this.getSingleDataUsecase,
    required this.getListDataUsecase,
  }) {
    createState(['create', 'single', 'find']);
  }

  Future<void> create({
    required DetailMeetingEntity entity,
    required List<String> listStudentId,
  }) async {
    updateState(state: RequestState.loading, key: 'create');

    final result = await createUsecase.execute(
      meeting: entity,
      listStudentId: listStudentId,
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

  Future<void> fetch({String? classroomUid}) async {
    updateState(state: RequestState.loading, key: 'find');

    final result = await getListDataUsecase.execute(classroomUid: classroomUid);

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
