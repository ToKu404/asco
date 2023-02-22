import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/state/request_state.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/usecases/profile_usecases/create_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/get_list_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/get_single_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/remove_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/self_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/update_profile.dart';

class ProfileNotifier extends CrudDataService<DetailProfileEntity> {
  final CreateProfile createUsecase;
  final GetListProfile getListDataUsecase;
  final GetSingleProfile getSingleUsecase;
  final RemoveProfile removeDataUsecase;
  final UpdateProfile updateDataUsecase;
  final SelfProfile selfDataUsecase;

  ProfileNotifier({
    required this.createUsecase,
    required this.getListDataUsecase,
    required this.getSingleUsecase,
    required this.removeDataUsecase,
    required this.updateDataUsecase,
    required this.selfDataUsecase,
  }) {
    createState(['create', 'find', 'me']);
  }

  Future<void> createProfile(DetailProfileEntity entity) async {
    updateState(state: RequestState.loading, key: 'create');
    notifyListeners();
    try {
      final result = await createUsecase.execute(userEntity: entity);
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
      notifyListeners();
    }
  }

  Future<void> fetchAll({int? roleId}) async {
    updateState(state: RequestState.loading, key: 'find');
    try {
      final result = await getListDataUsecase.execute(byRole: roleId);
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

  /// Self User Profile
  Future<void> getSelfDetail() async {
    updateState(state: RequestState.loading, key: 'me');
    notifyListeners();
    try {
      final result = await selfDataUsecase.execute();
      result.fold((l) {
        updateState(state: RequestState.error, key: 'me');
        setErrorMessage(l.message);
      }, (r) {
        updateState(state: RequestState.success, key: 'me');
        setData(r);
      });
      notifyListeners();
    } catch (e) {
      updateState(state: RequestState.error, key: 'me');
      setErrorMessage(e.toString());
      notifyListeners();
    }
  }
}
