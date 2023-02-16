class UpdateHelper {
  final Map<String, dynamic> _map = {};
  UpdateHelper();

  void onUpdate(String key, dynamic value) {
    if (value != null && value != '') {
      _map[key] = value;
    }
  }

  Map<String, dynamic> get map => _map;
}
