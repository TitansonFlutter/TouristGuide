import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';
import 'package:tourist_guide_app/dataProvider/filterDataProvider/filter_data_provider.dart';

class FilterRepository {
  final FilterDataProvider _dataProvider;

  FilterRepository(this._dataProvider);

  Future<List<Tour>> fetchAllTours() async {
    return this._dataProvider.fetchAllTours();
  }

  Future<List<Tour>> filter(List<dynamic> filters) async {
    return this._dataProvider.filter(filters);
  }

  Future<List<Tour>> fetchTourByName(String tourName) async {
    return this._dataProvider.getTourByName(tourName);
  }
}
