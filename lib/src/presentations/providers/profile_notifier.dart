import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/states/request_state.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/user_practicum_helper.dart';
import 'package:asco/src/domain/usecases/profile_usecases/create_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/get_list_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/get_multiple_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/get_single_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/multiple_practicum_update.dart';
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
  final GetMultipleProfile getMultipleUsecase;
  final UpdateMultiplePracticums multiplePracticumUpdateUsecase;

  ProfileNotifier({
    required this.createUsecase,
    required this.getListDataUsecase,
    required this.getSingleUsecase,
    required this.removeDataUsecase,
    required this.updateDataUsecase,
    required this.selfDataUsecase,
    required this.getMultipleUsecase,
    required this.multiplePracticumUpdateUsecase,
  }) {
    createState([
      'create',
      'find',
      'me',
      'multiple',
      'update_practicums',
      'by_classroom'
    ]);
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

  Future<void> fetchAll({int? roleId, String? practicumUid}) async {
    updateState(state: RequestState.loading, key: 'find');
    try {
      final result = await getListDataUsecase.execute(
          roleId: roleId, practicumUid: practicumUid);
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

  Future<void> fetchMultiple({required List<String> multipleId}) async {
    updateState(state: RequestState.loading, key: 'multiple');
    try {
      final result = await getMultipleUsecase.execute(multipleId: multipleId);
      result.fold((l) {
        updateState(state: RequestState.error, key: 'multiple');
        setErrorMessage(l.message);
      }, (r) {
        updateState(state: RequestState.success, key: 'multiple');
        setListData(r);
      });
      notifyListeners();
    } catch (e) {
      updateState(state: RequestState.error, key: 'multiple');
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

  Future<void> multiplePracticumUpdate(
      {required Map<String, Map<String, UserPracticumHelper>> data}) async {
    updateState(state: RequestState.loading, key: 'update_practicums');
    notifyListeners();
    try {
      final result = await multiplePracticumUpdateUsecase.execute(data: data);
      result.fold((l) {
        updateState(state: RequestState.error, key: 'update_practicums');
        setErrorMessage(l.message);
      }, (r) {
        updateState(state: RequestState.success, key: 'update_practicums');
      });
      notifyListeners();
    } catch (e) {
      updateState(state: RequestState.error, key: 'update_practicums');
      setErrorMessage(e.toString());
      notifyListeners();
    }
  }
}
