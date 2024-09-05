import 'package:flutter/material.dart';
import 'package:wp_test/presentation/screens/home_screen.dart';
import 'package:wp_test/presentation/screens/process_screen.dart';

class AppRouter {
  Route? onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(title: 'Home'),
        );

      case '/process':
        return MaterialPageRoute(
          builder: (_) => ProcessScreen(title: "Process"),
        );

      default:
        return null;
    }
  }
}
