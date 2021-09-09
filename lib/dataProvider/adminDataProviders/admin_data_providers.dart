import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tourist_guide_app/outException.dart';
import 'package:tourist_guide_app/Presentation/Models/User.dart';

class AdminDataProvider {
  static final String _url = "http://10.6.250.221:5000/api/admin";
// Get all Agents
  Future<List<User>> fetchAllAgents() async {
    final response = await http.get(Uri.parse("$_url/agents"));

    if (response.statusCode == 200) {
      print(response.body);
      final agents = jsonDecode(response.body) as List;
      return agents.map((user) => User.fromJson(user)).toList();
    } else {
      final err = jsonDecode(response.body);
      throw AppExc(err["message"]);
    }
  }

// Add new agent
  Future<User> addAgent(User user) async {
    final http.Response response = await http.post(Uri.parse("$_url/agents"),
        headers: <String, String>{
          "Content-Type": "application/json",
        },
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

// Delete Agent
  Future<User> deleteAgent(int id) async {
    final response = await http.delete(Uri.parse("$_url/agents/$id"));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      final err = jsonDecode(response.body);
      throw AppExc(err["message"]);
    }
  }
}
