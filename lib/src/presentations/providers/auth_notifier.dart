import 'package:asco/core/state/request_state.dart';
import 'package:asco/src/domain/entities/auth_entities/user_credential.dart';
import 'package:asco/src/domain/entities/auth_entities/user_entity.dart';
import 'package:asco/src/domain/usecases/auth_usecases/create_user.dart';
import 'package:asco/src/domain/usecases/auth_usecases/login.dart';
import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier {
  final CreateUser createUserUsecase;
  final Login loginUsecase;

  AuthNotifier({required this.createUserUsecase, required this.loginUsecase});

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
}
