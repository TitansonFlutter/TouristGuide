import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';
import 'package:tourist_guide_app/dataProvider/agentDataProviders/agentDataProviders/agent_data_provider.dart';
import 'package:tourist_guide_app/dataProvider/agentDataProviders/agent_data_provider.dart';

class AgentRepository {
  final AgentDataProvider _dataProvider;

  AgentRepository(this._dataProvider);

  Future<List<Tour>> fetchAllTours(int id) async {
    return this._dataProvider.fetchAllTours(id);
  }

  Future<Tour> addTour(int aId, Tour tour) async {
    return this._dataProvider.addTour(aId, tour);
  }

  Future<Tour> deleteTour(int aId, int tId) async {
    return this._dataProvider.deleteTour(aId, tId);
  }

  Future<Tour> updateTour(int aId, int tId, Tour tour) async {
    return this._dataProvider.updateTour(aId, tId, tour);
  }
}
