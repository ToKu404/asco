import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/states/request_state.dart';
import 'package:asco/src/domain/entities/auth_entities/user_credential_entity.dart';
import 'package:asco/src/domain/entities/auth_entities/user_entity.dart';
import 'package:asco/src/domain/usecases/auth_usecases/auth_usecases.dart';

class AuthNotifier extends CrudDataService<UserCredentialEntity> {
  final CreateUser createUsecase;
  final LogIn loginUsecase;
  final LogOut logoutUsecase;
  final GetUser singleUsecase;
  final RemoveUser removeUserUsecase;

  AuthNotifier({
    required this.createUsecase,
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.singleUsecase,
    required this.removeUserUsecase,
  }) {
    createState(['create', 'login', 'logout', 'single', 'remove']);
  }

  Future<void> createUser(UserEntity entity) async {
    updateState(state: RequestState.loading, key: 'create');

    final result = await createUsecase.execute(userEntity: entity);

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

  Future<void> login(String username, String password) async {
    updateState(state: RequestState.loading, key: 'login');

    final result = await loginUsecase.execute(
      username: username,
      password: password,
    );

    result.fold(
      (l) {
        updateState(state: RequestState.error, key: 'login');

        setErrorMessage(l.message);
      },
      (r) {
        updateState(state: RequestState.success, key: 'login');

        setData(r);
      },
    );
  }

  Future<void> logout() async {
    updateState(state: RequestState.loading, key: 'logout');

    final result = await logoutUsecase.execute();

    result.fold(
      (l) {
        updateState(state: RequestState.error, key: 'logout');

        setErrorMessage(l.message);
      },
      (r) {
        updateState(state: RequestState.success, key: 'logout');

        setData(null);

        updateState(state: RequestState.init, key: 'login');
      },
    );
  }

  Future<void> getUser() async {
    updateState(state: RequestState.loading, key: 'single');

    final result = await singleUsecase.execute();

    result.fold(
      (l) {
        updateState(state: RequestState.error, key: 'single');

        setData(null);

        setErrorMessage(l.message);
      },
      (r) {
        updateState(state: RequestState.success, key: 'single');

        setData(r);
      },
    );
  }

  Future<void> deleteUser(String username) async {
    updateState(state: RequestState.loading, key: 'remove');

    final result = await removeUserUsecase.execute(username: username);

    result.fold(
      (l) {
        updateState(state: RequestState.error, key: 'remove');

        setErrorMessage(l.message);
      },
      (r) {
        updateState(state: RequestState.success, key: 'remove');
      },
    );
  }
}
