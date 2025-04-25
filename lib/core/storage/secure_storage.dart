import 'package:shared_preferences/shared_preferences.dart';

import '../utils/logger.dart';

class Preference {
  static SharedPreferences ?_sf;
  static final Preference _preference = Preference._internal();
  factory Preference() {
    return _preference;
  }

  Preference._internal() {
    _initPreference();
  }

  _initPreference() async {
    debugLog("init prefernce called");
    if (_sf == null) {
      _sf = await SharedPreferences.getInstance();
      debugLog("Preference instance created");
    } else {
      debugLog("Preference instance Already there");
    }
  }

  int getInt(String key, {int defaultValue= 0}) {
    return _sf?.getInt(key) ?? -1;
  }

  String getString(String key, {String defaultValue = ''}) {
    return _sf?.getString(key) ?? defaultValue;
  }

  double getDouble(String key, {double defaultValue = 0.0}) {
    return _sf?.getDouble(key) ?? defaultValue;
  }

  bool getBool(String key, {bool defaultValue = true}) {
    return _sf?.getBool(key) ?? false;
  }

  List<String>? getListString(String key, {List<String> defaultValue = const ['null']}) {
    return _sf?.getStringList(key);
  }

  bool containsKey(String key) {
    return _sf?.containsKey(key) ?? false;
  }

  Future<bool?> clear() async {
    return await _sf?.clear();
  }

  Future<bool> remove(String key) async {
    return await _sf!.remove(key);
  }

  Future<bool?> setInt(String key, int value) async {
    return await _sf?.setInt(key, value);
  }

  Future<bool?> setString(String key, String value) async {
    return await _sf?.setString(key, value);
  }

  Future<bool?> setDouble(String key, double value) async {
    return await _sf?.setDouble(key, value);
  }

  Future<bool?> setBool(String key, bool value) async {
    return await _sf?.setBool(key, value);
  }

  Future<bool?> setStringList(String key, List<String> value) async {
    return await _sf?.setStringList(key, value);
  }





//MARK:-
  Future<bool?> set(String key, dynamic value) {
    switch (value.runtimeType) {
      case String:
        return setString(key, value);
        break;
      case int:
        return setInt(key, value);
        break;
      case double:
        return setDouble(key, value);
        break;
      case bool:
        return setBool(key, value);
        break;
      default:
        return Future.value(false);
    }
  }

  dynamic get(String key, dynamic defaultVal) {
    switch (defaultVal.runtimeType) {
      case String:
        return getString(key, defaultValue: defaultVal);
        break;
      case int:
        return getInt(key, defaultValue: defaultVal);
        break;
      case double:
        return getDouble(key, defaultValue: defaultVal);
        break;
      case bool:
        return getBool(key, defaultValue: defaultVal);
        break;
      default:
        return Future.value(false);
    }
  }

  Future<void> clearAllExcept(String keyToKeep, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    final String key = keyToKeep; // Replace with your actual key
    await prefs.clear();
    switch (value.runtimeType) {
      case String:
        await prefs.setString(key, value as String);
        break;
      case int:
        await prefs.setInt(key, value as int);
        break;
    }
  }
}