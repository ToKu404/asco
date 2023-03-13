import 'package:flutter/material.dart';
import 'package:asco/core/state/request_state.dart';

/// Generic type of class type send on `T`
class CrudDataService<T> with ChangeNotifier {
  // Instance of map state
  Map<String, RequestState> mapState = {};

  // Instances of data and list of data
  T? _data;
  List<T> _listData = [];

  // Instance of message
  String _message = '';

  // Data and list data getter
  T? get data => _data;
  List<T> get listData => _listData;

  // Message getter
  String get message => _message;

  // State comparison
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

  /// Reset all states
  void reset() {
    mapState.forEach((key, value) {
      mapState[key] = RequestState.init;
    });

    _data = null;
    _listData = [];
    _message = '';
  }

  /// Create state(s)
  void createState(List<String> keys) {
    for (var k in keys) {
      mapState[k] = RequestState.init;
    }

    notifyListeners();
  }

  /// Update state
  void updateState({required String key, required RequestState state}) {
    mapState[key] = state;

    notifyListeners();
  }

  void setData(T? data) {
    _data = data;

    notifyListeners();
  }

  void setListData(List<T> listData) {
    _listData = listData;

    notifyListeners();
  }

  void setErrorMessage(String message) {
    _message = message;

    notifyListeners();
  }
}
