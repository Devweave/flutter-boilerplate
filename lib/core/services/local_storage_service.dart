import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocalStorageService {
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _userDataKey = 'user_data';

  final FlutterSecureStorage _secureStorage;

  LocalStorageService(this._secureStorage);

  // Authentication related methods
  Future<bool> setLoggedIn(bool isLoggedIn) async {
    try {
      await _secureStorage.write(
        key: _isLoggedInKey,
        value: isLoggedIn.toString(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    final value = await _secureStorage.read(key: _isLoggedInKey);
    return value == 'true';
  }

  Future<bool> setUserData(Map<String, dynamic> userData) async {
    try {
      await _secureStorage.write(
        key: _userDataKey,
        value: json.encode(userData),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final userDataString = await _secureStorage.read(key: _userDataKey);
    if (userDataString != null) {
      return json.decode(userDataString) as Map<String, dynamic>;
    }
    return null;
  }

  Future<bool> clearUserData() async {
    try {
      await _secureStorage.delete(key: _userDataKey);
      await _secureStorage.delete(key: _isLoggedInKey);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Generic methods for other data
  Future<bool> setString(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getString(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<bool> setBool(String key, bool value) async {
    try {
      await _secureStorage.write(key: key, value: value.toString());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final value = await _secureStorage.read(key: key);
    return value == 'true' ? true : (value == 'false' ? false : defaultValue);
  }

  Future<bool> setInt(String key, int value) async {
    try {
      await _secureStorage.write(key: key, value: value.toString());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<int> getInt(String key, {int defaultValue = 0}) async {
    final value = await _secureStorage.read(key: key);
    return value != null ? int.tryParse(value) ?? defaultValue : defaultValue;
  }

  Future<bool> remove(String key) async {
    try {
      await _secureStorage.delete(key: key);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clear() async {
    try {
      await _secureStorage.deleteAll();
      return true;
    } catch (e) {
      return false;
    }
  }
}
