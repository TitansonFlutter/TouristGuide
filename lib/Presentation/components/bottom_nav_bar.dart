import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide_app/Presentation/core/Agent/home_screen.dart';
import 'package:tourist_guide_app/Presentation/core/History/history.dart';
import 'package:tourist_guide_app/Presentation/core/admin/home_screen.dart';
import 'package:tourist_guide_app/Presentation/core/home/home.dart';
import 'package:tourist_guide_app/Presentation/core/searchAndFilter/home.dart';

class BottomNavBar extends StatefulWidget {
  // final int index;
  // final List<String> _options = ["Home", "Search, Agents", "History"];
  BottomNavBar();
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,

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
      onTap: (i) {
        setState(() {
          _page = i;
        });
        if (i == 0) {
          Navigator.of(context).pushNamed(HomeScreen.routeName);
        }
        if (i == 1) {
          Navigator.of(context).pushNamed(FilterScreenMain.routeName);
        }
        if (i == 2) {
          Navigator.of(context).pushNamed(AdminHome.routeName);
        }
        if (i == 3) {
          Navigator.of(context).pushNamed(HistoryPage.routeName);
        }
      },
    );
  }
}
