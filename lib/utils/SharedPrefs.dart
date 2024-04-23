import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _sharedPreferences;

  static const String _isLoggedIn = 'isLoggedIn';
  static const String _profilePicture = 'profilePicture';
  static const String _firstName = 'firstName';
  static const String _lastName = 'lastName';

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static bool get isLoggedIn =>
      _sharedPreferences.getBool(_isLoggedIn) ?? false;
  static set isLoggedIn(bool value) =>
      _sharedPreferences.setBool(_isLoggedIn, value);

  static String get profilePicture =>
      _sharedPreferences.getString(_profilePicture) ?? '';
  static set profilePicture(String value) =>
      _sharedPreferences.setString(_profilePicture, value);

  static String get firstName => _sharedPreferences.getString(_firstName) ?? '';
  static set firstName(String value) =>
      _sharedPreferences.setString(_firstName, value);

  static String get lastName => _sharedPreferences.getString(_lastName) ?? '';
  static set lastName(String value) =>
      _sharedPreferences.setString(_lastName, value);

  static Future<bool> clearAll() async {
    return await _sharedPreferences.clear();
  }
}
