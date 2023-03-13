import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateHelper {
  final _map = <String, dynamic>{};

  Map<String, dynamic> get map => _map;

  void onUpdate(String key, dynamic value) {
    if (value != null && value != '') {
      _map[key] = value;
    }
  }
}

class ReadHelper {
  static bool isKeyExist(DocumentSnapshot snapshot, String key) {
    return snapshot.data().toString().contains(key) && snapshot[key] != null;
  }
}
