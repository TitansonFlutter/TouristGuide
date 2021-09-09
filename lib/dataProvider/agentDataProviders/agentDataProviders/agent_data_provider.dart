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

// Update Tour
  Future<Tour> updateTour(int aId, int tId, Tour tour) async {
    final http.Response response =
        await http.put(Uri.parse("$_url/$aId/tours/$tId"),
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
      throw Exception("Couldn't update tour ...");
    }
  }

// Delete Tour
  Future<Tour> deleteTour(int aId, int tId) async {
    final response = await http.delete(Uri.parse("$_url/$aId/tours/$tId"));
    if (response.statusCode == 200) {
      return Tour.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not Delete the tour");
    }
  }

  Future<http.StreamedResponse> patchImage(
      int aId, String filepath, Tour tour) async {
    // String token = await storage.read(key: "token");
    var request = http.MultipartRequest('PATCH', Uri.parse("$_url/$aId/tours"));
    request.fields['data'] = jsonEncode(tour);
    request.files.add(
      await http.MultipartFile.fromPath("img", filepath),
    );
    // request.headers.addAll({
    //   "Content-type": "multipart/form-data",
    //   // "Authorization": "Bearer $token"
    // });
    var response = await request.send();
    if (response.statusCode == 200) {
      print(response);
      return response;
    } else {
      throw Exception("Could not add the tour");
    }
  }
}
