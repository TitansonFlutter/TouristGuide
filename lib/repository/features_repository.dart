import 'package:tourist_guide_app/Presentation/Models/User.dart';
import 'package:tourist_guide_app/Presentation/Models/review_model.dart';
import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';
import 'package:tourist_guide_app/dataProvider/featureDataProvider/features_data_provider.dart';

class FeaturesRepository {
  final FeaturesDataProvider _dataProvider;
  FeaturesRepository(this._dataProvider);

  Future<List<Tour>> fetchAllTours() async {
    return this._dataProvider.fetchAllTours();
  }

  Future<Review> addReview(Review review) async {
    return this._dataProvider.addReview(review);
  }

  Future<List<Review>> fetchAllReviews(int tId) async {
    return this._dataProvider.fetchAllReviews(tId);
  }

  Future<User> bookStatus(int uId, int tId) async {
    return this._dataProvider.bookStatus(uId, tId);
  }
}
