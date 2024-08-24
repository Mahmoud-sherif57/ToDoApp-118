import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static late SharedPreferences _prefs;
  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

// first function (set) to store value locale..
  static Future<bool> set({required String key, required dynamic value}) async {
    if (value is int) {
      return await _prefs.setInt(key, value);
    } else if (value is double) {
      return await _prefs.setDouble(key, value);
    } else if (value is bool) {
      return await _prefs.setBool(key, value);
    } else if (value is String) {
      return await _prefs.setString(key, value);
    } else if (value is List<String>) {
      return await _prefs.setStringList(key, value);
    } else {
      return false;
    }
  }

// 2d function (get) to get the value from locale storage..
  static Object? get({required String key}) {
    return _prefs.get(key);
  }

// 3d function (remove) to remove the value from locale storage..
  static Future<bool> remove({required String key}) async {
    return await _prefs.remove(key);
  }

// 4th function (clear all) to remove all the values from locale storage..
  static Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}
