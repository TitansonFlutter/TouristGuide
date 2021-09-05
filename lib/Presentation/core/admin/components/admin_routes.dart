import 'package:flutter/material.dart';
import 'agent_display.dart';

class AdminRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => AgentsDisplay());
    }
    return MaterialPageRoute(builder: (context) => AgentsDisplay());
  }
}
