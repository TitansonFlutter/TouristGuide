import 'package:flutter/material.dart';

import '../Presentation/Models/tour_list.dart';
import '../Presentation/core/admin/home_screen.dart';

class Routes {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => WelcomePage());
    }
// Auth
    if (settings.name == LoginPage.routeName) {
      return MaterialPageRoute(builder: (context) => LoginPage());
    }
    if (settings.name == SignUpPage.routeName) {
      return MaterialPageRoute(builder: (context) => SignUpPage());
    }
    // Bottom Navigation

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
