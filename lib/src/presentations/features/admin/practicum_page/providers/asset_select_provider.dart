import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:flutter/foundation.dart';

class AssetSelectedProvider with ChangeNotifier {
  bool _isClicked = false;

  bool get isClicked => _isClicked;

  void setIsClicked(bool status) {
    _isClicked = status;
    notifyListeners();
  }

  final List<ProfileEntity> _assets = [];

  List<ProfileEntity> get asset => _assets;

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
