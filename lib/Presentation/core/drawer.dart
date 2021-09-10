import 'package:flutter/material.dart';

import 'Profile/profile.dart';

class MainDrawer extends StatelessWidget {
  static final String routeName = "/drawer";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 270,
          child: DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('../assets/images/avatar.png'),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Biruk Ayalew",
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                Text(
                  "se.b.ayalew@gmail.com",
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side:
                                  BorderSide(color: Colors.blue, width: 6.0)))),
                  child: Text('Edit'),
                  onPressed: () {
                    Navigator.pushNamed(context, Profile.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                title: Text(
                  "Settings",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: Text(
                  "Log out",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
