import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tourist_guide_app/outException.dart';
import 'package:tourist_guide_app/Presentation/Models/User.dart';
import 'package:tourist_guide_app/Presentation/Models/review_model.dart';

import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';

class FeaturesDataProvider {
  static final String _url = "http://10.6.250.16:5000/api";

// Get all Tours
  Future<List<Tour>> fetchAllTours() async {
    final response = await http.get(Uri.parse("$_url/agents/2/tours"));
    if (response.statusCode == 200) {
      final tours = jsonDecode(response.body) as List;
      return tours.map((tour) => Tour.fromJson(tour)).toList();
    } else {
      final err = jsonDecode(response.body);
      throw AppExc(err["message"]);
    }
  }

// // Add a Reviews
  Future<Review> addReview(Review review) async {
    final http.Response response =
        await http.post(Uri.parse("$_url/features/reviews"),
            headers: <String, String>{"Content-Type": "application/json"},
            body: jsonEncode({
              "UserId": review.userId,
              "Name": review.tourId,
              "Comment": review.comment,
              "Rate": review.rate,
              "Date": review.date
            }));
    if (response.statusCode == 201) {
      return Review.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to add your Review");
    }
  }

  // GEt All Reviews
  Future<List<Review>> fetchAllReviews(int tId) async {
    final response = await http.get(Uri.parse("$_url/features/reviews/$tId"));
    if (response.statusCode == 200) {
      final tours = jsonDecode(response.body) as List;
      print(tours);
      return tours.map((tour) => Review.fromJson(tour)).toList();
    } else {
      // print("Error");
      final err = jsonDecode(response.body);
      throw AppExc(err["message"]);
    }
  }

// Get Tour by Id
  Future<Tour> getTour(int id, Tour tour) async {
    final response = await http.get(Uri.parse("$_url/tours/$id"));

    if (response.statusCode == 200) {
      return Tour.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not get the tour");
    }
  }

  Future<User> bookStatus(int uId, int tId) async {
    final response = await http.get(Uri.parse("$_url/users/$uId/book/$tId"));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not get Book Status");
    }
  }
}
