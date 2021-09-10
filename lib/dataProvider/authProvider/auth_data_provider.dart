import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tourist_guide_app/appConstants.dart';
import 'package:tourist_guide_app/outException.dart';
import 'package:tourist_guide_app/Presentation/Models/User.dart';

class AuthDataProvider {
// Add new user sign up
  Future<User> signup(User user) async {
    final http.Response response = await http.post(Uri.parse("$url/auth"),
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
      final err = jsonDecode(response.body);
      throw AppExc(err["message"]);
    }
  }

  // login
  Future<User> login(User user) async {
    final http.Response response = await http.post(Uri.parse("$url/auth/login"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "Email": user.email,
          "Password": user.password,
        }));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      final err = jsonDecode(response.body);
      throw AppExc(err["message"]);
    }
  }

  // edit
  Future<User> updateProfile(User user, int id) async {
    final http.Response response = await http.put(Uri.parse("$url/auth/$id"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "Email": user.email,
          "Password": user.password,
          "UserName": user.username,
          "Role": user.role,
        }));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      final err = jsonDecode(response.body);
      throw AppExc(err["message"]);
    }
  }
}
