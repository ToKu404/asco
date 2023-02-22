import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:flutter/foundation.dart';

class AssistantSelectedProvider with ChangeNotifier {
  late List<ProfileEntity> _assets;

  AssistantSelectedProvider({List<ProfileEntity>? init}) {
    if (init == null) {
      _assets = [];
    } else {
      _assets = init;
    }
  }

  bool _isClicked = false;

  bool get isClicked => _isClicked;

  void setIsClicked(bool status) {
    _isClicked = status;
    notifyListeners();
  }

  List<ProfileEntity> get assistant => _assets;

  bool isItemSelected(ProfileEntity asset) {
    return _assets.contains(asset) ? true : false;
  }

  void addAsset(ProfileEntity asset) {
    _assets.add(asset);
    notifyListeners();
  }

  void removeAsset(ProfileEntity asset) {
    _assets.remove(asset);
    notifyListeners();
  }
}
