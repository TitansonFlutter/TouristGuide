import 'package:flutter/material.dart';
import 'package:tourist_guide_app/Presentation/components/app_bar.dart';
import 'package:tourist_guide_app/Presentation/components/bottom_nav_bar.dart';
import 'package:tourist_guide_app/Presentation/components/hamburger_menu.dart';
import 'package:tourist_guide_app/Presentation/components/user_avatar.dart';

import 'package:tourist_guide_app/Presentation/core/home/components/places_categoris.dart';
import 'package:tourist_guide_app/Presentation/core/home/components/popular_places.dart';
import 'package:tourist_guide_app/Presentation/core/home/components/recommended.dart';
import 'package:tourist_guide_app/Presentation/core/home/components/recommended_places.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: buildAppBar(context,
          title: 'Discover', leading: HamburgerMenu(), actions: [UserAvatar()]),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            PlacesCategories(),
            PopularPlaces(),
            Recommended(),
            RecommendedPlaces()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
