import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';
import 'package:tourist_guide_app/dataProvider/history_data_provider.dart';

class HistoryRepository {
  final HistoryDataProvider _dataProvider;

  HistoryRepository(this._dataProvider);

  Future<List<Tour>> fetchAllUpcomingHistory(int id) async {
    return this._dataProvider.fetchAllUpcomingHistory(id);
  }

  Future<List<Tour>> fetchAllPastHistory(int id) async {
    return this._dataProvider.fetchAllPastHistory(id);
  }
}
