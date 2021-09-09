import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';

class AgentDataProvider {
  static final String _url = "http://localhost:5000/api/agents";
// Get all Tours
  Future<List<Tour>> fetchAllTours(int id) async {
    final response = await http.get(Uri.parse("$_url/$id/tours"));
    if (response.statusCode == 200) {
      final tours = jsonDecode(response.body) as List;
      return tours.map((tour) => Tour.fromJson(tour)).toList();
    } else {
      throw Exception("Could not fetch tours");
    }
  }

// Add new agent
  Future<Tour> addTour(int id, Tour tour) async {
    final http.Response response = await http.post(Uri.parse("$_url/$id/tours"),
        headers: <String, String>{
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "TourNme": tour.tourName,
          "TourImage": tour.tourImage,
          "Country": tour.country,
          "Region": tour.region,
          "City": tour.city,
          "WhatToInclude": tour.whatToInclude,
          "WhatToExclude": tour.whatToExclude,
          "TourDescription": tour.tourDescription,
          "WhatToBring": tour.whatToBring,
          "Itinerary": tour.itinerary,
          "Duration": tour.duration,
          "StartingDate": tour.startingDate,
          "Price": tour.price,
          "Updated": tour.updated,
        }));
    if (response.statusCode == 201) {
      return Tour.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Couldn't add tour ...");
    }
  }
}