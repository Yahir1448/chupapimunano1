import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  final ValueNotifier<bool> _isDarkModeNotifier = ValueNotifier<bool>(false);

  ThemeProvider(bool initialDarkMode) {
    _isDarkMode = initialDarkMode;
    _isDarkModeNotifier.value = initialDarkMode;
  }

  bool get isDarkMode => _isDarkMode;

  ValueNotifier<bool> get isDarkModeNotifier => _isDarkModeNotifier;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _isDarkModeNotifier.value = _isDarkMode;
    _saveThemePreference();
    notifyListeners();
  }

  Future<void> _saveThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
  }
}
