import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static const String themeMode = "themeMode";
  static const String language = "language";

  static StorageManager? _storageUtils;
  static SharedPreferences? _preferences;

  /// Creates a singleton for the shared preferences
  static Future<StorageManager?> getInstance() async {
    if (_storageUtils == null) {
      var sec = StorageManager._();
      await sec._init();
      _storageUtils = sec;
    }
    return _storageUtils;
  }

  StorageManager._();

  Future _init() async => _preferences = await SharedPreferences.getInstance();

  /// Saves a dynamic [bool] value into the Shared Preferences with a defined [key]
  static saveBoolData(String key, bool value) {
    _preferences?.setBool(key, value);
  }

  /// Reads the data from the Share Preferences based on the given [key]
  static bool readBoolData(String key) => _preferences?.getBool(key) ?? false;

  /// Saves a dynamic [String] value into the Shared Preferences with a defined [key]
  static saveStringData(String key, String value) {
    _preferences?.setString(key, value);
  }

  /// Reads the data from the Share Preferences based on the given [key]
  static String readStringData(String key) => _preferences?.getString(key) ?? "";
}