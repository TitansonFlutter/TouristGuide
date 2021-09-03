import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tourist_guide_app/Presentation/Models/User.dart';

class AuthDataProvider {
  static final String _url = "http://192.168.122.1/api/auth";

// Add new user sign up
  Future<User> signup(User user) async {
    final http.Response response = await http.post(Uri.parse("$_url"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "Email": user.email,
          "UserName": user.username,
          "Role": user.role,
          "Password": user.password,
        }));
    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Couldn't add user ...");
    }
  }

  // login
  Future<User> login(User user) async {
    final http.Response response = await http.post(Uri.parse("$_url/login"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "Email": user.username,
          "Password": user.password,
        }));
    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Couldn't get user info ...");
    }
  }
}
