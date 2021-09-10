import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tourist_guide_app/outException.dart';
import 'package:tourist_guide_app/appConstants.dart';
import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';

class FilterDataProvider {
// Get all Tours
  Future<List<Tour>> fetchAllTours() async {
    final response = await http.get(Uri.parse("$url/features/recommended"));
    if (response.statusCode == 200) {
      final tours = jsonDecode(response.body) as List;

      return tours.map((tour) => Tour.fromJson(tour)).toList();
    } else {
      throw Exception("Could not fetch tours");
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

//   Future<Tour> getTour(int id, Tour tour) async {
//     final response = await http.get(Uri.parse("$_url/tours/$id"));

//     if (response.statusCode == 200) {
//       return Tour.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception("Could not get the tour");
//     }
//   }

//Filter

  Future<List<Tour>> filter(List<dynamic> filters) async {
    print(filters);

    final http.Response response = await http.post(Uri.parse("$url/filters"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "priceHigh": filters[0],
          "priceLow": filters[1],
          "tourName": filters[2],
          // "Speciality": filter.special
        }));

    if (response.statusCode == 200) {
      final tours = jsonDecode(response.body) as List;

      return tours.map((tour) => Tour.fromJson(tour)).toList();
    } else {
      final err = jsonDecode(response.body);
      throw AppExc(err["message"]);
    }
  }

//Filter by name
  Future<List<Tour>> getTourByName(String tourName) async {
    final http.Response response =
        await http.get(Uri.parse("$url/filters/$tourName"));
    if (response.statusCode == 200) {
      final tours = jsonDecode(response.body) as List;

      return tours.map((tour) => Tour.fromJson(tour)).toList();
    } else {
      final err = jsonDecode(response.body);
      throw AppExc(err["message"]);
    }
  }
}
