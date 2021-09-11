import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tourist_guide_app/appConstants.dart';
import 'package:tourist_guide_app/outException.dart';
import 'package:tourist_guide_app/Presentation/Models/User.dart';
import 'package:tourist_guide_app/Presentation/Models/review_model.dart';

import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';

class FeaturesDataProvider {
// Get all Tours
  Future<List<Tour>> fetchAllTours() async {
    final response = await http.get(Uri.parse("$url/features/recommended"));
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
        await http.post(Uri.parse("$url/features/reviews"),
            headers: <String, String>{"Content-Type": "application/json"},
            body: jsonEncode({
              "UserId": review.userId,
              "TourId": review.tourId,
              "Comment": review.comment,
              "Rate": review.rate,
              "Date": review.date
            }));
    if (response.statusCode == 201) {
      print(response.body);
      return Review.fromJson(jsonDecode(response.body));
    } else {
      print("Error");
      throw Exception("Failed to add your Review");
    }
  }

  // GEt All Reviews
  Future<List<Review>> fetchAllReviews(int tId) async {
    final response = await http.get(Uri.parse("$url/features/reviews/$tId"));
    if (response.statusCode == 200) {
      final tours = jsonDecode(response.body) as List;
      print(tours);
      return tours.map((tour) => Review.fromJson(tour)).toList();
    } else {
      print("Error");
      final err = jsonDecode(response.body);
      throw AppExc(err["message"]);
    }
  }

// Get Tour by Id
  Future<Tour> getTour(int id, Tour tour) async {
    final response = await http.get(Uri.parse("$url/tours/$id"));

    if (response.statusCode == 200) {
      return Tour.fromJson(jsonDecode(response.body));
    } else {
      final err = jsonDecode(response.body);
      throw AppExc(err["message"]);
    }
  }

  Future<User> bookStatus(int uId, int tId) async {
    final response = await http.get(Uri.parse("$url/users/$uId/book/$tId"));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      final err = jsonDecode(response.body);
      throw AppExc(err["message"]);
    }
  }

  // // Book a Tour
  Future<User> book(int uId, int tourId) async {
    final http.Response response =
        await http.post(Uri.parse("$url/users/$uId/book"),
            headers: <String, String>{"Content-Type": "application/json"},
            body: jsonEncode({
              "TourId": tourId,
            }));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      final err = jsonDecode(response.body);
      print(err);
      throw AppExc(err["message"]);
    }
  }
}
