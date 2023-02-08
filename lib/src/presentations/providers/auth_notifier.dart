import 'package:asco/core/state/request_state.dart';
import 'package:asco/src/domain/entities/auth_entities/user_credential.dart';
import 'package:asco/src/domain/entities/auth_entities/user_entity.dart';
import 'package:asco/src/domain/usecases/auth_usecases/create_user.dart';
import 'package:asco/src/domain/usecases/auth_usecases/get_user.dart';
import 'package:asco/src/domain/usecases/auth_usecases/login.dart';
import 'package:asco/src/domain/usecases/auth_usecases/logout.dart';
import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier {
  final CreateUser createUserUsecase;
  final Login loginUsecase;
  final LogOut logoutUsecase;
  final GetUser getUserUsecase;

  AuthNotifier({
    required this.createUserUsecase,
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.getUserUsecase,
  });

  void reset() {
    _loginState == RequestState.init;
    _userCredentialEntity = null;
  }

  RequestState _createUserState = RequestState.init;
  String _createUserErrorMessage = '';
  String get createUserErrorMessage => _createUserErrorMessage;
  RequestState get createUserState => _createUserState;

  Future<void> createUser(UserEntity userEntity) async {
    _createUserState = RequestState.loading;
    notifyListeners();
    try {
      final result = await createUserUsecase.execute(userEntity: userEntity);
      result.fold((l) {
        _createUserState = RequestState.error;
        _createUserErrorMessage = l.message;
      }, (r) {
        _createUserState = RequestState.success;
      });
      notifyListeners();
    } catch (e) {
      _createUserState = RequestState.error;
      _createUserErrorMessage = e.toString();
      notifyListeners();
    }
  }

  RequestState _loginState = RequestState.init;
  String _loginErrorMessage = '';
  UserCredentialEntity? _userCredentialEntity;
  String get loginErrorMessage => _loginErrorMessage;
  RequestState get loginState => _loginState;
  UserCredentialEntity? get userCredentialEntity => _userCredentialEntity;
  Future<void> login(String userName, String password) async {
    _loginState = RequestState.loading;
    notifyListeners();
    try {
      final result =
          await loginUsecase.execute(username: userName, password: password);
      result.fold((l) {
        _loginState = RequestState.error;
        _loginErrorMessage = l.message;
      }, (r) {
        _loginState = RequestState.success;
        _userCredentialEntity = r;
      });
      notifyListeners();
    } catch (e) {
      _loginState = RequestState.error;
      _loginErrorMessage = e.toString();
      notifyListeners();
    }
  }

  String _logOutError = '';
  String get logOutError => _logOutError;
  RequestState _logOutState = RequestState.init;
  RequestState get logOutState => _logOutState;

  Future<void> logOut() async {
    try {
      final result = await logoutUsecase.execute();
      result.fold(
        (failure) {
          _logOutError = failure.message;
          _logOutState = RequestState.error;
        },
        (user) {
          _logOutState = RequestState.success;
          _userCredentialEntity = null;
          _loginState = RequestState.init;
        },
      );
      notifyListeners();
    } catch (e) {
      _logOutState = RequestState.error;
      _logOutError = e.toString();
      notifyListeners();
    }
  }

  RequestState _getUserState = RequestState.init;
  RequestState get getUserstate => _getUserState;
  String _getUserError = '';
  String get error => _getUserError;

  void getUser() async {
    try {
      final result = await getUserUsecase.execute();
      result.fold(
        (failure) {
          _getUserError = failure.message;
          _userCredentialEntity = null;
          _getUserState = RequestState.error;
        },
        (user) {
          _userCredentialEntity = user;
          _getUserState = RequestState.success;
        },
      );
      notifyListeners();
    } catch (e) {
      _getUserState = RequestState.error;
      _getUserError = e.toString();
      notifyListeners();
    }
  }
}
