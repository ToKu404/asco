import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:flutter/foundation.dart';

class UserSelectedProvider with ChangeNotifier {
  late List<ProfileEntity> _assets;

  UserSelectedProvider({List<ProfileEntity>? init}) {
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

  List<ProfileEntity> get user => _assets;

  bool isItemSelected(ProfileEntity asset) {
    return _assets.indexWhere((element) => element.uid == asset.uid) == -1
        ? false
        : true;
  }

  void addAsset(ProfileEntity asset) {
    _assets.add(asset);
    notifyListeners();
  }

  void removeAsset(ProfileEntity asset) {
    _assets.removeWhere((element) => element.uid == asset.uid);
    notifyListeners();
  }
}
