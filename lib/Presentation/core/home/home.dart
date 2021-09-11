import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide_app/LocalDB/AuthDB.dart';
import 'package:tourist_guide_app/Presentation/components/app_bar.dart';
import 'package:tourist_guide_app/Presentation/components/bottom_nav_bar.dart';
import 'package:tourist_guide_app/Presentation/components/hamburger_menu.dart';
import 'package:tourist_guide_app/Presentation/components/user_avatar.dart';
import 'package:tourist_guide_app/Presentation/core/drawer.dart';

import 'package:tourist_guide_app/Presentation/core/home/components/popular_places.dart';
import 'package:tourist_guide_app/Presentation/core/home/components/recommended.dart';
import 'package:tourist_guide_app/Presentation/core/popular_tour_list_view.dart';
import 'package:tourist_guide_app/SharedSimplePreference.dart';
import 'package:tourist_guide_app/bloc/featuresBloc/bloc.dart';
import 'package:tourist_guide_app/dataProvider/featureDataProvider/features_data_provider.dart';
import 'package:tourist_guide_app/repository/features_repository.dart';

class HomeScreen extends StatelessWidget {
  static final String routeName = '/home';
  final FeaturesRepository featuresRepository =
      FeaturesRepository(FeaturesDataProvider());

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.featuresRepository,
      child: BlocProvider(
        create: (context) =>
            FeaturesBloc(this.featuresRepository)..add(LoadTours()),
        child: Scaffold(
          key: scaffoldKey,
          // appBar: AppBar(
          // backgroundColor: Colors.deepOrange,
          //   elevation: 0,
          //   title: Text("Discover"),
          // ),
          drawer: Drawer(
            child: MainDrawer(),
          ),
          appBar: buildAppBar(
            context,
            title: 'Discover',
            leading: IconButton(
                icon: ClipOval(child: Image.asset('assets/images/menu.png')),
                onPressed: () {
                  scaffoldKey.currentState.openDrawer();
                }),
            actions: [
              UserAvatar(),
            ],
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        PopularPlaces(),
                        // Recommended(),
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
          bottomNavigationBar: BottomNavBar(0),
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
              color: Colors.black,
            ),
          ),
          Flexible(
            child: ToursListView(),
          )
        ],
      ),
    );
  }
}
