import 'package:asco/core/state/request_state.dart';
import 'package:flutter/foundation.dart';

class CrudDataService<T> with ChangeNotifier {
  void reset() {
    // _createState = RequestState.init;
    // _findState = RequestState.init;
    // _singleState = RequestState.init;
    // _updateState = RequestState.init;
    // _deleteState = RequestState.init;
    mapState.forEach((key, value) {
      mapState[key] = RequestState.init;
    });

    _data = null;
    _listData = [];
    _errorMessage = '';
  }

  Map<String, RequestState> mapState = {};

  // RequestState _createState = RequestState.init;
  // RequestState get createState => _createState;

  // RequestState _findState = RequestState.init;
  // RequestState get findState => _findState;

  // RequestState _singleState = RequestState.init;
  // RequestState get singleState => _singleState;

  // RequestState _updateState = RequestState.init;
  // RequestState get updateState => _updateState;

  // RequestState _deleteState = RequestState.init;
  // RequestState get deleteState => _deleteState;

  T? _data;
  List<T> _listData = [];

  List<T> get listData => _listData;
  T? get data => _data;

  String _errorMessage = '';
  String get message => _errorMessage;

  void createState(List<String> keys) {
    for (var k in keys) {
      mapState[k] = RequestState.init;
    }
    notifyListeners();
  }

  bool isInitState(String key) {
    return mapState[key] == RequestState.init;
  }

  bool isLoadingState(String key) {
    return mapState[key] == RequestState.loading;
  }

  bool isErrorState(String key) {
    return mapState[key] == RequestState.error;
  }

  bool isSuccessState(String key) {
    return mapState[key] == RequestState.success;
  }

  void updateState({required RequestState state, required String key}) {
    mapState[key] = state;
    notifyListeners();
  }

  // void setCreateState(RequestState state) {
  //   _createState = state;
  //   notifyListeners();
  // }

  // void setFindState(RequestState state) {
  //   _findState = state;
  //   notifyListeners();
  // }

  // void setSingleState(RequestState state) {
  //   _singleState = state;
  //   notifyListeners();
  // }

  // void setUpdateState(RequestState state) {
  //   _updateState = state;
  //   notifyListeners();
  // }

  // void setDeleteState(RequestState state) {
  //   _deleteState = state;
  //   notifyListeners();
  // }

  void setData(T? newData) {
    _data = newData;
    notifyListeners();
  }

  void setListData(List<T> newData) {
    _listData = newData;
    notifyListeners();
  }

  void setErrorMessage(String errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }
}
