import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide_app/Presentation/core/tour_info_screen.dart';
import 'package:tourist_guide_app/Presentation/core/popular_tour_list_view.dart';
import 'package:tourist_guide_app/bloc/featuresBloc/bloc.dart';
import 'package:tourist_guide_app/dataProvider/featureDataProvider/features_data_provider.dart';
import 'package:tourist_guide_app/repository/features_repository.dart';
import 'tour_app_theme.dart';

class TourHomeScreen extends StatefulWidget {
  @override
  _TourHomeScreenState createState() => _TourHomeScreenState();
}

class _TourHomeScreenState extends State<TourHomeScreen> {
  CategoryType categoryType = CategoryType.ui;
  final FeaturesRepository featuresRepository =
      FeaturesRepository(FeaturesDataProvider());
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.featuresRepository,
      child: BlocProvider(
        create: (context) =>
            FeaturesBloc(this.featuresRepository)..add(LoadTours()),
        child: Container(
          color: TourAppTheme.nearlyWhite,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                // getAppBarUI(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: <Widget>[
                          getSearchBarUI(),
                          // getCategoryUI(),
                          Flexible(
                            child: getPopularToursUI(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getPopularToursUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Popular Tours',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: TourAppTheme.darkerText,
            ),
          ),
          Flexible(
            child: ToursListView(),
          )
        ],
      ),
    );
  }

  void moveTo() {
    Navigator.of(context).pushNamed(TourInfoScreen.routeName);
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.ui == categoryTypeData) {
      txt = 'Ui/Ux';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = 'Coding';
    } else if (CategoryType.basic == categoryTypeData) {
      txt = 'Basic UI';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color:
                isSelected ? TourAppTheme.nearlyBlue : TourAppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: TourAppTheme.nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? TourAppTheme.nearlyWhite
                        : TourAppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: TourAppTheme.nearlyBlue,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Search for Tours',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: HexColor('#B9BABC'),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: HexColor('#B9BABC'),
                            ),
                          ),
                          onEditingComplete: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.search, color: HexColor('#B9BABC')),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Choose your',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      letterSpacing: 0.2,
                      color: TourAppTheme.grey,
                    ),
                  ),
                  Text(
                    'Destination Place',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      letterSpacing: 0.27,
                      color: TourAppTheme.darkerText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum CategoryType {
  ui,
  coding,
  basic,
}
