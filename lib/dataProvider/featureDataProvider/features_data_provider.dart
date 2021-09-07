import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tourist_guide_app/AuthException.dart';

import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';

class FeaturesDataProvider {
  static final String _url = "http://localhost/api/features";

// Get all Tours
  Future<List<Tour>> fetchAllTours() async {
    final response = await http.get(Uri.parse("$_url/tours"));

    if (response.statusCode == 200) {
      final tours = jsonDecode(response.body) as List;
      return tours.map((tour) => Tour.fromJson(tour)).toList();
    } else {
      final err = jsonDecode(response.body);
      throw AuthException(err["message"]);
    }
  }

// // Add a Reviews
//   Future<Review> addReview(Review review) async {
//     final http.Response response = await http.post(Uri.parse("$_url/review"),
//         headers: <String, String>{"Content-Type": "application/json"},
//         body: jsonEncode({
//           "BookId": review.bookId,
//           "UserId": review.userId,
//           "Comment": review.comment,
//           "Rate": review.rate,
//           "Date": review.date
//         }));
//     if (response.statusCode == 201) {
//       return Review.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception("Failed to add your Review");
//     }
//   }

  Future<Tour> getTour(int id, Tour tour) async {
    final response = await http.get(Uri.parse("$_url/tours/$id"));

    if (response.statusCode == 200) {
      return Tour.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not get the tour");
    }
  }

//Filter
  // Future<Tour> filter(List<String> filters) async {
  //   final http.Response response = await http.post(Uri.parse("$_url/tours"),
  //       headers: <String, String>{"Content-Type": "application/json"},
  //       body: jsonEncode({
  //         "PriceHigh": filters.highPrice,
  //         "PriceLow": filters.lowPrice,
  //         "Speciality": filters.special
  //       }));
  //   if (response.statusCode == 200) {
  //     return Review.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception("Something went wrong");
  //   }
  // }

// Future<Tour> getAllTours() async {
//     final http.Response response = await http.get(Uri.parse("$_url/tours"));
//     if (response.statusCode == 200) {
//       return Review.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception("Something went wrong");
//     }
//   }

// Future<Tour> getTourByName(String tourName) async {
//     final http.Response response = await http.get(Uri.parse("$_url/tours/$tourName"));
//     if (response.statusCode == 200) {
//       return Review.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception("Something went wrong");
//     }
//   }
}
