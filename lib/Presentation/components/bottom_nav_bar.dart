import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide_app/Presentation/core/History/history.dart';
import 'package:tourist_guide_app/Presentation/core/admin/home_screen.dart';
import 'package:tourist_guide_app/Presentation/core/home/home.dart';
import 'package:tourist_guide_app/Presentation/core/searchAndFilter/home.dart';
// import 'package:flutter_svg/svg.dart';
//import 'package:flutter_svg/flutter_svg.dart';
//import 'package:travel_app/constants.dart';

// class BottomNavBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 75,
//       width: double.infinity,
//       margin: EdgeInsets.all(15),
//       padding: EdgeInsets.symmetric(horizontal: 40),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(50),
//           color: Colors.blue,
//           boxShadow: [
//             BoxShadow(
//                 blurRadius: 20,
//                 offset: const Offset(0, 3),
//                 color: Colors.black.withAlpha(20))
//           ]),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           NavItem(
//             icon: 'assets/icons/home.svg',
//             isActive: true,
//           ),
//           NavItem(
//             icon: 'assets/icons/calendar.svg',
//             isActive: false,
//           ),
//           NavItem(
//             icon: 'assets/icons/search.svg',
//             isActive: false,
//           ),
//           NavItem(
//             icon: 'assets/icons/user.svg',
//             isActive: false,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class NavItem extends StatelessWidget {
//   const NavItem({Key key, @required this.icon, @required this.isActive})
//       : super(key: key);

//   final String icon;
//   final bool isActive;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Spacer(),
//         IconButton(icon: SvgPicture.asset(icon), onPressed: () {}),
//         Spacer(),
//         Container(
//           height: 4,
//           width: 35,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: isActive ? Color(0XFF6A62B7) : Colors.transparent,
//               boxShadow: [
//                 BoxShadow(
//                     blurRadius: 6,
//                     offset: const Offset(0, -2),
//                     color: isActive ? Color(0XFF6A62B7) : Colors.transparent)
//               ]),
//         )
//       ],
//     );
//   }

// }

class BottomNavBar extends StatefulWidget {
  List<String> _options = ["Home", "Search, Agents", "History"];
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
          Navigator.of(context).pushNamed(Body.routeName);
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
