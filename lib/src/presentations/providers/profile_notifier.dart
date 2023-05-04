import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/states/request_state.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/user_practicum_helper.dart';
import 'package:asco/src/domain/usecases/profile_usecases/profile_usecases.dart';

class ProfileNotifier extends CrudDataService<DetailProfileEntity> {
  final CreateProfile createUsecase;
  final GetSingleProfile getSingleUsecase;
  final GetMultipleProfile getMultipleUsecase;
  final GetListProfile getListDataUsecase;
  final UpdateProfile updateDataUsecase;
  final RemoveProfile removeDataUsecase;
  final SelfProfile selfDataUsecase;
  final UpdateMultiplePracticums updateMultiplePracticumsUsecase;
  final UploadProfilePicture uploadProfilePictureUseCase;
  final DeleteProfilePicture deleteProfilePictureUseCase;

  ProfileNotifier({
    required this.createUsecase,
    required this.getSingleUsecase,
    required this.getMultipleUsecase,
    required this.getListDataUsecase,
    required this.updateDataUsecase,
    required this.removeDataUsecase,
    required this.selfDataUsecase,
    required this.updateMultiplePracticumsUsecase,
    required this.uploadProfilePictureUseCase,
    required this.deleteProfilePictureUseCase,
  }) {
    createState([
      'create',
      'find',
      'self',
      'multiple',
      'update_practicums',
      'upload_profile_photo',
      'delete_profile_photo',
    ]);
  }

  Future<void> createProfile(DetailProfileEntity entity) async {
    updateState(state: RequestState.loading, key: 'create');

    final result = await createUsecase.execute(userProfileEntity: entity);

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

  Future<void> fetchAll({int? roleId, String? practicumUid}) async {
    updateState(state: RequestState.loading, key: 'find');

    final result = await getListDataUsecase.execute(
      roleId: roleId,
      practicumUid: practicumUid,
    );

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

  /// Self user profile
  Future<void> getSelfDetail() async {
    updateState(state: RequestState.loading, key: 'self');

    final result = await selfDataUsecase.execute();

    result.fold(
      (l) {
        updateState(state: RequestState.error, key: 'self');

        setErrorMessage(l.message);
      },
      (r) {
        updateState(state: RequestState.success, key: 'self');

        setData(r);
      },
    );
  }

  Future<void> fetchMultiple({required List<String> multipleId}) async {
    updateState(state: RequestState.loading, key: 'multiple');

    final result = await getMultipleUsecase.execute(multipleId: multipleId);

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

  Future<void> multiplePracticumUpdate({
    required Map<String, Map<String, UserPracticumHelper>> data,
  }) async {
    updateState(state: RequestState.loading, key: 'update_practicums');

    final result = await updateMultiplePracticumsUsecase.execute(data: data);

    result.fold(
      (l) {
        updateState(state: RequestState.error, key: 'update_practicums');

        setErrorMessage(l.message);
      },
      (r) {
        updateState(state: RequestState.success, key: 'update_practicums');
      },
    );
  }

  Future<void> uploadProfilePicture(
    String path,
    String uid,
    String filename,
  ) async {
    updateState(state: RequestState.loading, key: 'upload_profile_photo');

    final result = await uploadProfilePictureUseCase.execute(
      path,
      uid,
      filename,
    );

    result.fold(
      (l) {
        updateState(state: RequestState.error, key: 'upload_profile_photo');

        setErrorMessage(l.message);
      },
      (r) {
        updateState(state: RequestState.success, key: 'upload_profile_photo');

        setData(data!.copyWith(profilePhoto: r));
      },
    );
  }

  Future<void> deleteProfilePicture(String uid, String filename) async {
    updateState(state: RequestState.loading, key: 'delete_profile_photo');

    final result = await deleteProfilePictureUseCase.execute(uid, filename);

    result.fold(
      (l) {
        updateState(state: RequestState.error, key: 'delete_profile_photo');

        setErrorMessage(l.message);
      },
      (r) {
        updateState(state: RequestState.success, key: 'delete_profile_photo');
      },
    );
  }
}
