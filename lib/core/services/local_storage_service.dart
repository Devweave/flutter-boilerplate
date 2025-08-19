import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class LocalStorageService {
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _userDataKey = 'user_data';

  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  // Authentication related methods
  Future<bool> setLoggedIn(bool isLoggedIn) async {
    return await _prefs.setBool(_isLoggedInKey, isLoggedIn);
  }

  bool isLoggedIn() {
    return _prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<bool> setUserData(Map<String, dynamic> userData) async {
    return await _prefs.setString(_userDataKey, json.encode(userData));
  }

  Map<String, dynamic>? getUserData() {
    final userDataString = _prefs.getString(_userDataKey);
    if (userDataString != null) {
      return json.decode(userDataString) as Map<String, dynamic>;
    }
    return null;
  }

  Future<bool> clearUserData() async {
    await _prefs.remove(_userDataKey);
    return await _prefs.remove(_isLoggedInKey);
  }

  // Generic methods for other data
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  Future<bool> clear() async {
    return await _prefs.clear();
  }
}
