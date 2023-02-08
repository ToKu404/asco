import 'package:asco/src/data/models/auth_models/user_credential.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Auth Preferences Helper
/// Save auth session and token on shared prefrences
class AuthPreferenceHelper {
  static AuthPreferenceHelper? _preferenceHelper;
  AuthPreferenceHelper._instance() {
    _preferenceHelper = this;
  }
  static SharedPreferences? _preferences;

  Future<SharedPreferences?> get preferences async {
    _preferences ??= await _initPreference();
    return _preferences;
  }

  factory AuthPreferenceHelper() =>
      _preferenceHelper ?? AuthPreferenceHelper._instance();

  static SharedPreferences? sharedPreferences;

  Future<SharedPreferences> _initPreference() async {
    final pr = await SharedPreferences.getInstance();
    return pr;
  }

  // Key
  static const userNameKey = 'USER_NAME';
  static const userRoleKey = 'USER_ROLE';

  /// For Save User Credential Data
  Future<bool> setUserData(UserCredentialModel user) async {
    final pr = await preferences;
    try {
      pr!.setString(userNameKey, user.username);
      pr.setInt(userRoleKey, user.roleId);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// For Get Use Credential Data
  Future<UserCredentialModel?> getUser() async {
    final pr = await preferences;
    if (pr!.containsKey(userNameKey)) {
      String? username = pr.getString(userNameKey);
      int? role = pr.getInt(userRoleKey);

      return UserCredentialModel(roleId: role!, username: username!);
    } else {
      return null;
    }
  }

  /// For Delete User Credential Data
  Future<bool> removeUserData() async {
    final pr = await preferences;
    try {
      pr!.remove(userRoleKey);
      pr.remove(userNameKey);

      return true;
    } catch (e) {
      return false;
    }
  }
}
