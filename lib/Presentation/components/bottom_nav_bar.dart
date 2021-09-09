import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide_app/Presentation/core/Agent/home_screen.dart';
import 'package:tourist_guide_app/Presentation/core/History/history.dart';
import 'package:tourist_guide_app/Presentation/core/admin/home_screen.dart';
import 'package:tourist_guide_app/Presentation/core/home/home.dart';
import 'package:tourist_guide_app/Presentation/core/searchAndFilter/home.dart';

class BottomNavBar extends StatefulWidget {
  // final List<String> _options = ["Home", "Search, Agents", "History"];
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 60,
      color: Color(0XFF6A62B7),
      buttonBackgroundColor: Color(0XFF6A62B7),
      backgroundColor: Colors.transparent,
      // animationDuration: Duration(seconds: 1),
      // animationCurve: Curves.bounceOut,
      items: <Widget>[
        Icon(Icons.home, color: Colors.white),
        Icon(Icons.search, color: Colors.white),
        Icon(Icons.favorite, color: Colors.white),
        Icon(Icons.history, color: Colors.white),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.of(context).pushNamed(HomeScreen.routeName);
        }
        if (index == 1) {
          Navigator.of(context).pushNamed(AgentHome.routeName);
        }
        if (index == 2) {
          Navigator.of(context).pushNamed(AdminHome.routeName);
        }
        if (index == 3) {
          Navigator.of(context).pushNamed(HistoryPage.routeName);
        }
      },
    );
  }
}
