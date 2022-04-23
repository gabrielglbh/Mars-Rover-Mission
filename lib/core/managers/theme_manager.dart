import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/managers/storage_manager.dart';

part '../../ui/theme/dark.dart';
part '../../ui/theme/light.dart';

const String lightTheme = "light";
const String darkTheme = "dark";

class ThemeManager {
  ThemeNotifier? _notifier;

  ThemeManager._() {
    _notifier = ThemeNotifier();
  }

  static final ThemeManager _instance = ThemeManager._();

  /// Singleton instance of [ThemeManager]
  static ThemeManager get instance => _instance;

  ThemeMode get themeMode => _notifier?.isDarkTheme == true ? ThemeMode.dark : ThemeMode.light;
  ThemeData? get currentLightThemeData => light;
  ThemeData? get currentDarkThemeData => dark;

  /// Switch the theme mode on the device
  switchMode(bool mode) => _notifier?.setMode(mode);

  /// Adds a custom listener to the [_notifier]
  addListenerTo(Function() listener) => _notifier?.addListener(listener);
}

class ThemeNotifier with ChangeNotifier {
  late bool isDarkTheme;

  ThemeNotifier([bool isDarkTheme = false]) {
    _setDarkTheme(isDarkTheme);
    _getCurrentTheme();
  }

  _setDarkTheme(bool darkTheme) => isDarkTheme = darkTheme;

  _getCurrentTheme() {
    bool? mode = StorageManager.readBoolData(StorageManager.themeMode);
    if (mode) isDarkTheme = mode;
    notifyListeners();
  }

  /// Sets the actual theme mode in the Shared Preferences and notifies the listeners
  /// that the value has changed to apply it to the UI
  setMode(bool mode) {
    isDarkTheme = mode;
    StorageManager.saveBoolData(StorageManager.themeMode, isDarkTheme);
    notifyListeners();
  }
}