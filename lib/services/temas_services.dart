import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TemasServices {
  final _box = GetStorage();
  final _key = 'isDarkMode';
  _saveTheme(bool isDarkMode) => _box.write(_key, isDarkMode);
  bool _loadTemaDeGetStore() => _box.read(_key) ?? false;
  ThemeMode get theme =>
      _loadTemaDeGetStore() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(
        _loadTemaDeGetStore() ? ThemeMode.light : ThemeMode.dark);
    _saveTheme(!_loadTemaDeGetStore());
  }
}
