import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/models/user_model.dart';

//Authentication manager

class AuthController {
  static final String _accessTokenKey = 'acess_token';
  static final String _userKey = 'user';

  static String? accessToken;
  static UserModel? user;

  static Future<void> saveUserData(String token, UserModel userModel) async {
    // Save token and user data in shared preferences
    final sharedPreference = await SharedPreferences.getInstance();
    await sharedPreference.setString(_accessTokenKey, token);
    await sharedPreference.setString(_userKey, jsonEncode(userModel.toJson()));
    user = userModel;
    accessToken = token;
  }

  static Future<void> loadUserData() async {
    final sharedPreference = await SharedPreferences.getInstance();
    accessToken = sharedPreference.getString(_accessTokenKey);

    user = UserModel.fromJson(
      jsonDecode(sharedPreference.getString(_userKey)!),
    );
  }

  static Future<bool> isUserLoggedIn() async {
    final sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getString(_accessTokenKey) != null;
  }

  static Future<void> clearUserData() async {
    final sharedPreference = await SharedPreferences.getInstance();
    await sharedPreference.remove(_accessTokenKey);
    await sharedPreference.remove(_userKey);
  }
}
