import '../../Presentation/Models/User.dart';
import '../../dataProvider/adminDataProviders/admin_data_providers.dart';

class AdminRepository {
  final AdminDataProvider _dataProvider;

  AdminRepository(this._dataProvider);

  Future<User> addAgent(User user) async {
    return this._dataProvider.addAgent(user);
  }

  Future<User> deleteAgent(int id) async {
    return this._dataProvider.deleteAgent(id);
  }

  Future<List<User>> fetchAllAgents() async {
    return this._dataProvider.fetchAllAgents();
  }
}
