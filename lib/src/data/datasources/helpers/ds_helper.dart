import 'package:cloud_firestore/cloud_firestore.dart';

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

class ReadHelper {
  static bool isKeyExist(DocumentSnapshot snapshot, String key) {
    return snapshot.data().toString().contains(key) && snapshot[key] != null;
  }
}
