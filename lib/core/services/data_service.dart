import 'package:asco/core/state/request_state.dart';
import 'package:flutter/foundation.dart';

//* generic type of class type send on <T>
class CrudDataService<T> with ChangeNotifier {

  //* reset state and data
  void reset() {
    mapState.forEach((key, value) {
      mapState[key] = RequestState.init;
    });

    _data = null;
    _listData = [];
    _errorMessage = '';
  }

  //* instance state, data, list data, message
  Map<String, RequestState> mapState = {};
  T? _data;
  List<T> _listData = [];
  List<T> get listData => _listData;
  T? get data => _data;
  String _errorMessage = '';
  String get message => _errorMessage;

  //* State Compraison
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

  //* Set and update data, state, and error message
  void createState(List<String> keys) {
    for (var k in keys) {
      mapState[k] = RequestState.init;
    }
    notifyListeners();
  }

  void updateState({required RequestState state, required String key}) {
    mapState[key] = state;
    notifyListeners();
  }

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
