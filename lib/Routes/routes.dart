import 'package:flutter/material.dart';
import 'package:tourist_guide_app/Presentation/core/Agent/components/tour_add.dart';
import 'package:tourist_guide_app/Presentation/core/Agent/home_screen.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/loginPage.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/signup.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/welcomePage.dart';

import 'package:tourist_guide_app/Presentation/core/History/history.dart';
import 'package:tourist_guide_app/Presentation/core/Profile/profile.dart';
import 'package:tourist_guide_app/Presentation/core/admin/components/agent_add.dart';
import 'package:tourist_guide_app/Presentation/core/home/home.dart';
import 'package:tourist_guide_app/Presentation/core/searchAndFilter/home.dart';
import 'package:tourist_guide_app/Presentation/core/tour_info_screen.dart';

import '../Presentation/Models/tour_list.dart';
import '../Presentation/core/admin/home_screen.dart';

class Routes {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => WelcomePage());
    }
    if (settings.name == Profile.routeName) {
      return MaterialPageRoute(builder: (context) => Profile());
    }
// Auth
    if (settings.name == LoginPage.routeName) {
      return MaterialPageRoute(builder: (context) => LoginPage());
    }
    if (settings.name == SignUpPage.routeName) {
      return MaterialPageRoute(builder: (context) => SignUpPage());
    }
    // Bottom Navigation
    if (settings.name == HomeScreen.routeName) {
      return MaterialPageRoute(builder: (context) => HomeScreen());
    }
    if (settings.name == FilterScreenMain.routeName) {
      return MaterialPageRoute(builder: (context) => FilterScreenMain());
    }
    if (settings.name == HistoryPage.routeName) {
      return MaterialPageRoute(builder: (context) => HistoryPage());
    }
    // Admin
    if (settings.name == AdminHome.routeName) {
      return MaterialPageRoute(builder: (context) => AdminHome());
    }
    if (settings.name == AgentAdd.routeName) {
      return MaterialPageRoute(builder: (context) => AgentAdd());
    }

    // Tour
    if (settings.name == TourInfoScreen.routeName) {
      Tour tour = settings.arguments as Tour;
      return MaterialPageRoute(builder: (context) => TourInfoScreen(tour));
    }

    if (settings.name == AgentHome.routeName) {
      return MaterialPageRoute(builder: (context) => AgentHome());
    }
    if (settings.name == TourAdd.routeName) {
      return MaterialPageRoute(builder: (context) => TourAdd());
    }
  }
}

class TourArgument {
  final Tour course;
  final bool edit;
  TourArgument({this.course, @required this.edit});
}
