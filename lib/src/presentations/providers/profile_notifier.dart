import 'package:asco/core/state/request_state.dart';
import 'package:asco/src/domain/entities/profile_entities/user_profile_entity.dart';
import 'package:asco/src/domain/usecases/profile_usecases/create_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/get_list_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/get_single_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/remove_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/self_profile.dart';
import 'package:asco/src/domain/usecases/profile_usecases/update_profile.dart';
import 'package:flutter/material.dart';

class ProfileNotifier extends ChangeNotifier {
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
  });

  void reset() {
    _createProfileState = RequestState.init;
  }

  RequestState _createProfileState = RequestState.init;
  String _createProfileErrorMessage = '';
  String get createProfileErrorMessage => _createProfileErrorMessage;
  RequestState get createProfileState => _createProfileState;

  Future<void> createProfile(UserProfileEntity userEntity) async {
    _createProfileState = RequestState.loading;
    notifyListeners();
    try {
      final result = await createProfileUsecase.execute(userEntity: userEntity);
      result.fold((l) {
        _createProfileState = RequestState.error;
        _createProfileErrorMessage = l.message;
      }, (r) {
        _createProfileState = RequestState.success;
      });
      notifyListeners();
    } catch (e) {
      _createProfileState = RequestState.error;
      _createProfileErrorMessage = e.toString();
      notifyListeners();
    }
  }

  ///
  RequestState _fetchAllProfileState = RequestState.init;
  String _fetchAllProfileErrorMessage = '';
  String get fetchAllProfileErrorMessage => _fetchAllProfileErrorMessage;
  RequestState get fetchAllProfileState => _fetchAllProfileState;

  List<UserProfileEntity> _listProfile = [];
  List<UserProfileEntity> get listProfile => _listProfile;

  Future<void> fetchAll() async {
    _fetchAllProfileState = RequestState.loading;
    notifyListeners();
    try {
      final result = await getListProfileUsecase.execute();
      result.fold((l) {
        _fetchAllProfileState = RequestState.error;
        _fetchAllProfileErrorMessage = l.message;
      }, (r) {
        _fetchAllProfileState = RequestState.success;
        _listProfile = r;
      });
      notifyListeners();
    } catch (e) {
      _fetchAllProfileState = RequestState.error;
      _fetchAllProfileErrorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Self User Profile
  RequestState _detailSelfProfileState = RequestState.init;
  String _detailSelfProfileErrorMessage = '';
  String get detailSelfProfileErrorMessage => _detailSelfProfileErrorMessage;
  RequestState get detailSelfProfileState => _detailSelfProfileState;

  UserProfileEntity? _detailSelfProfile;
  UserProfileEntity? get detailSelfProfile => _detailSelfProfile;

  Future<void> getSelfDetail() async {
    _detailSelfProfileState = RequestState.loading;
    notifyListeners();
    try {
      final result = await selfProfileUsecase.execute();
      result.fold((l) {
        _detailSelfProfileState = RequestState.error;
        _detailSelfProfileErrorMessage = l.message;
      }, (r) {
        _detailSelfProfileState = RequestState.success;
        _detailSelfProfile = r;
      });
      notifyListeners();
    } catch (e) {
      _detailSelfProfileState = RequestState.error;
      _detailSelfProfileErrorMessage = e.toString();
      notifyListeners();
    }
  }
}
