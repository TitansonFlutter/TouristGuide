import 'package:tourist_guide_app/Presentation/Models/User.dart';
import 'package:tourist_guide_app/dataProvider/authProvider/auth_data_provider.dart';

class AuthRepository {
  final AuthDataProvider _dataProvider;

  AuthRepository(this._dataProvider);

  Future<User> login(User user) async {
    return this._dataProvider.login(user);
  }

  Future<User> signup(User user) async {
    return this._dataProvider.signup(user);
  }

  Future<User> updateProfile(User user, int id) async {
    return this._dataProvider.updateProfile(user, id);
  }
}
