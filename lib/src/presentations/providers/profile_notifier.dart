import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/state/request_state.dart';
import 'package:asco/src/domain/entities/profile_entities/user_profile_entity.dart';
import 'package:asco/src/domain/usecases/profile_usecases/create_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/get_list_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/get_single_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/remove_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/self_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/update_profile.dart';

class ProfileNotifier extends CrudDataService<UserProfileEntity> {
  final CreateProfile createProfileUsecase;
  final GetListProfile getListProfileUsecase;
  final GetSingleProfile getSingleProfileUsecase;
  final RemoveProfile removeProfileUsecase;
  final UpdateProfile updateProfileUsecase;
  final SelfProfile selfProfileUsecase;

  ProfileNotifier({
    required this.createProfileUsecase,
    required this.getListProfileUsecase,
    required this.getSingleProfileUsecase,
    required this.removeProfileUsecase,
    required this.updateProfileUsecase,
    required this.selfProfileUsecase,
  }) {
    createState(['create', 'find', 'me']);
  }

  Future<void> createProfile(UserProfileEntity entity) async {
    updateState(state: RequestState.loading, key: 'create');
    notifyListeners();
    try {
      final result = await createProfileUsecase.execute(userEntity: entity);
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

  Future<void> fetchAll() async {
    updateState(state: RequestState.loading, key: 'find');
    try {
      final result = await getListProfileUsecase.execute();
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
      final result = await selfProfileUsecase.execute();
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
