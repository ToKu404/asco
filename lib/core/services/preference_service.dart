import 'package:shared_preferences/shared_preferences.dart';
import 'package:asco/core/utils/exception.dart';
import 'package:asco/src/data/models/auth_models/user_credential_model.dart';

/// **Auth Preferences Helper**
///
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
    return await SharedPreferences.getInstance();
  }

  // Key
  static const usernameKey = 'USER_NAME';
  static const userRoleKey = 'USER_ROLE';

  /// For save user credential data
  Future<bool> setUserData(UserCredentialModel user) async {
    final pref = await preferences;

    try {
      if (pref != null) {
        pref.setString(usernameKey, user.username);
        pref.setInt(userRoleKey, user.roleId);

        return true;
      }

      return false;
    } catch (e) {
      throw PreferenceException(e.toString());
    }
  }

  /// For get use credential data
  Future<UserCredentialModel?> getUser() async {
    final pref = await preferences;

    if (pref != null) {
      if (pref.containsKey(usernameKey) && pref.containsKey(userRoleKey)) {
        final username = pref.getString(usernameKey)!;
        final role = pref.getInt(userRoleKey)!;

        return UserCredentialModel(roleId: role, username: username);
      }
    }

    return null;
  }

  /// For delete user credential data
  Future<bool> removeUserData() async {
    final pref = await preferences;

    try {
      if (pref != null) {
        pref.remove(usernameKey);
        pref.remove(userRoleKey);

        return true;
      }

      return false;
    } catch (e) {
      throw PreferenceException(e.toString());
    }
  }
}
