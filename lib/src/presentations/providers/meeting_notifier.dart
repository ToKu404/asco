import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/states/request_state.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:asco/src/domain/usecases/meeting_usecases/create_meeting.dart';
import 'package:asco/src/domain/usecases/meeting_usecases/get_list_meeting.dart';
import 'package:asco/src/domain/usecases/meeting_usecases/get_single_meeting.dart';

class MeetingNotifier extends CrudDataService<DetailMeetingEntity> {
  final CreateMeeting createUsecase;
  final GetListMeeting getListDataUsecase;
  final GetSingleMeeting getSingleDataUsecase;

  MeetingNotifier({
    required this.createUsecase,
    required this.getListDataUsecase,
    required this.getSingleDataUsecase,
  }) {
    createState(['create', 'find', 'single']);
  }

  //* Create
  Future<void> create({
    required DetailMeetingEntity entity,
    required List<String> listStudentId,
  }) async {
    updateState(state: RequestState.loading, key: 'create');
    try {
      final result = await createUsecase.execute(
        entity: entity,
        listStudentId: listStudentId,
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
  Future<void> fetch({String? classroomUid}) async {
    updateState(state: RequestState.loading, key: 'find');
    try {
      final result =
          await getListDataUsecase.execute(classroomUid: classroomUid);
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
