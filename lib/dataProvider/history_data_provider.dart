import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';

class HistoryDataProvider {
  static final String _url = "http://127.0.0.1:5000/api/users";

// Get Upcomming History
  Future<List<Tour>> fetchAllUpcomingHistory(int id) async {
    final response = await http.get(Uri.parse("$_url/$id/history/upcoming"));
    if (response.statusCode == 200) {
      final tours = jsonDecode(response.body) as List;
      return tours.map((tour) => Tour.fromJson(tour)).toList();
    } else {
      throw Exception("Could not fetch tours");
    }
  }

// Get Upcomming History
  Future<List<Tour>> fetchAllPastHistory(int id) async {
    final response = await http.get(Uri.parse("$_url/$id/history/past"));
    if (response.statusCode == 200) {
      final tours = jsonDecode(response.body) as List;
      return tours.map((tour) => Tour.fromJson(tour)).toList();
    } else {
      throw Exception("Could not fetch tours");
    }
  }
}
