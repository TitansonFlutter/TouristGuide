import 'package:flutter/material.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Components/body.dart';
import 'package:tourist_guide_app/Presentation/core/home/home.dart';
import 'package:tourist_guide_app/Presentation/core/searchAndFilter/home.dart';
import 'package:tourist_guide_app/Presentation/core/searchAndFilter/mainHome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App UI',
      debugShowCheckedModeBanner: false,
      home: LogInBody(),
    );
  }
}
