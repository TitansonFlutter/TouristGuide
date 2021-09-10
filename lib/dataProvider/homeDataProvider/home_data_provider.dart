import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class HomeDataProvider {
  final _baseUrl = 'http//locallhost/5000/tour';
  final http.Client httpClient;

  HomeDataProvider(this.httpClient) : assert(httpClient != null);


  Future<List<Tour>> getRecommended() async {
    final response = await httpClient.get('$_baseUrl/places');

    if (response.statusCode == 200) {
      final places = jsonDecode(response.body) as List;
      return places.map((place) => Tour.fromJson(places)).toList();
    } else {
      throw Exception('Failed to load Recommended');
    }
  }
}
  

 
