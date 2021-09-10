import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';
import 'package:tourist_guide_app/appConstants.dart';
import 'package:tourist_guide_app/outException.dart';

class HistoryDataProvider {
// Get Upcomming History
  Future<List<Tour>> fetchAllUpcomingHistory(int id) async {
    final response =
        await http.get(Uri.parse("$url/users/$id/history/upcoming"));
    if (response.statusCode == 200) {
      final tours = jsonDecode(response.body) as List;
      return tours.map((tour) => Tour.fromJson(tour)).toList();
    } else {
      final err = jsonDecode(response.body);
      throw AppExc(err["message"]);
    }
  }

// Get Upcomming History
  Future<List<Tour>> fetchAllPastHistory(int id) async {
    final response = await http.get(Uri.parse("$url/users/$id/history/past"));
    if (response.statusCode == 200) {
      final tours = jsonDecode(response.body) as List;
      return tours.map((tour) => Tour.fromJson(tour)).toList();
    } else {
      final err = jsonDecode(response.body);
      throw AppExc(err["message"]);
    }
  }
}
