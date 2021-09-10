import 'package:meta/meta.dart';
import 'package:tourist_guide_app/Presentation/core/home/home.dart';

class HomeRepository{
  final HomeDataProvider homeDataProvider;
  HomeRepository(this.homeDataProvider)
   :assert(homeDataProvider != null);

   Future<List<Tour>> getRecommended() async{
     return await homeDataProvider.getRecommended();
   }
}
