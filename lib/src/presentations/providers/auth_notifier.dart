import 'package:asco/core/services/data_service.dart';
import 'package:asco/core/state/request_state.dart';
import 'package:asco/src/domain/entities/auth_entities/user_credential.dart';
import 'package:asco/src/domain/entities/auth_entities/user_entity.dart';
import 'package:asco/src/domain/usecases/auth_usecases/create_user.dart';
import 'package:asco/src/domain/usecases/auth_usecases/get_user.dart';
import 'package:asco/src/domain/usecases/auth_usecases/login.dart';
import 'package:asco/src/domain/usecases/auth_usecases/logout.dart';
import 'package:asco/src/domain/usecases/auth_usecases/remove_user.dart';

class AuthNotifier extends CrudDataService<UserCredentialEntity> {
  final CreateUser createUserUsecase;
  final Login loginUsecase;
  final LogOut logoutUsecase;
  final GetUser getUserUsecase;
  final RemoveUser removeUserUsecase;

  AuthNotifier({
    required this.createUserUsecase,
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.getUserUsecase,
    required this.removeUserUsecase,
  }) {
    createState(['create', 'login', 'logout', 'single']);
  }

  Future<void> createUser(UserEntity entity) async {
    updateState(state: RequestState.loading, key: 'create');
    notifyListeners();
    try {
      final result = await createUserUsecase.execute(userEntity: entity);
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

  Future<void> login(String userName, String password) async {
    updateState(state: RequestState.loading, key: 'login');
    notifyListeners();
    try {
      final result =
          await loginUsecase.execute(username: userName, password: password);
      result.fold((l) {
        updateState(state: RequestState.error, key: 'login');
        setErrorMessage(l.message);
      }, (r) {
        updateState(state: RequestState.success, key: 'login');
        setData(r);
      });
      notifyListeners();
    } catch (e) {
      updateState(state: RequestState.error, key: 'login');
      setErrorMessage(e.toString());
    }
  }

  Future<void> logOut() async {
    try {
      final result = await logoutUsecase.execute();
      result.fold(
        (failure) {
          updateState(state: RequestState.error, key: 'logout');
          setErrorMessage(failure.message);
        },
        (user) {
          updateState(state: RequestState.error, key: 'logout');
          setData(null);
          updateState(state: RequestState.init, key: 'login');
        },
      );
      notifyListeners();
    } catch (e) {
      updateState(state: RequestState.error, key: 'logout');
      setErrorMessage(e.toString());
    }
  }

  void getUser() async {
    try {
      final result = await getUserUsecase.execute();
      result.fold(
        (failure) {
          updateState(state: RequestState.error, key: 'single');
          setData(null);
          setErrorMessage(failure.message);
        },
        (user) {
          updateState(state: RequestState.success, key: 'single');
          setData(user);
        },
      );
      notifyListeners();
    } catch (e) {
      updateState(state: RequestState.error, key: 'single');
      setErrorMessage(e.toString());
    }
  }
}
