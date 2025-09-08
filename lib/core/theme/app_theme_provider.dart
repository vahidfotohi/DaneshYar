import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 1. Provider
final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});

// 2. Notifier
class ThemeNotifier extends Notifier<ThemeMode> {
  static const _themePrefsKey = 'themeMode';

  @override
  ThemeMode build() {
    // Load the theme mode from storage when the provider is first created
    _loadThemeFromPrefs();
    return ThemeMode.light; // Default value
  }

  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themePrefsKey);
    if (themeIndex != null) {
      state = ThemeMode.values[themeIndex];
    }
  }

  Future<void> _saveThemeToPrefs(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themePrefsKey, themeMode.index);
  }

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _saveThemeToPrefs(state);
  }

  void setTheme(ThemeMode themeMode) {
    state = themeMode;
    _saveThemeToPrefs(state);
  }
}
