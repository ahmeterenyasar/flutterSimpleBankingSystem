import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../utils/constants.dart';

class StorageService {
  static StorageService? _instance;
  SharedPreferences? _prefs;

  StorageService._();

  static Future<StorageService> getInstance() async {
    if (_instance == null) {
      _instance = StorageService._();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> saveUser(User user) async {
    try {
      final jsonString = jsonEncode(user.toJson());
      return await _prefs!.setString(AppConstants.userDataKey, jsonString);
    } catch (e) {
      print('Error saving user: $e');
      return false;
    }
  }

  Future<User?> loadUser() async {
    try {
      final jsonString = _prefs!.getString(AppConstants.userDataKey);
      if (jsonString == null) return null;

      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return User.fromJson(jsonMap);
    } catch (e) {
      print('Error loading user: $e');
      return null;
    }
  }

  Future<bool> hasUser() async {
    return _prefs!.containsKey(AppConstants.userDataKey);
  }

  Future<bool> deleteUser() async {
    try {
      return await _prefs!.remove(AppConstants.userDataKey);
    } catch (e) {
      print('Error deleting user: $e');
      return false;
    }
  }

  Future<bool> clearAll() async {
    try {
      return await _prefs!.clear();
    } catch (e) {
      print('Error clearing data: $e');
      return false;
    }
  }
}
