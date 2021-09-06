import 'package:flutter/material.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Components/login.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/SignUP/signup.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Welcome/welcomeScreen.dart';
import 'package:tourist_guide_app/Presentation/core/History/history.dart';
import 'package:tourist_guide_app/Presentation/core/home/home.dart';
import 'package:tourist_guide_app/Presentation/core/searchAndFilter/home.dart';

import '../Presentation/Models/tour_list.dart';
import '../Presentation/core/admin/home_screen.dart';

class Routes {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
    }
// Auth
    if (settings.name == LoginScreen.routeName) {
      return MaterialPageRoute(builder: (context) => LoginScreen());
    }
    if (settings.name == SignUpPage.routeName) {
      return MaterialPageRoute(builder: (context) => SignUpPage());
    }
    // Bottom Navigation
    if (settings.name == HomeScreen.routeName) {
      return MaterialPageRoute(builder: (context) => HomeScreen());
    }
    if (settings.name == Body.routeName) {
      return MaterialPageRoute(builder: (context) => Body());
    }
    // if (settings.name == AgentHome.routeName) {
    //   return MaterialPageRoute(builder: (context) => AgentHome());
    // }
    if (settings.name == HistoryPage.routeName) {
      return MaterialPageRoute(builder: (context) => HistoryPage());
    }
    // Admin
    if (settings.name == AdminHome.routeName) {
      return MaterialPageRoute(builder: (context) => AdminHome());
    }
  }
}

class TourArgument {
  final Tour course;
  final bool edit;
  TourArgument({this.course, @required this.edit});
}
