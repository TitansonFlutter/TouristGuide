import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'Presentation/Models/User.dart';

class UserSimplePreferences {
  static SharedPreferences preferences;
  static const _keyUser = "user";

  static Future init() async =>
      preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    try {
      await preferences.setString(_keyUser, json.encode(user));
    } catch (e) {
      print("Not working");
    }
  }

  static User getUser() {
    try {
      return User.fromJson(json.decode(preferences.getString(_keyUser)));
    } catch (e) {
      print("Working");
      // throw new Exception("dd");
    }
  }
}
