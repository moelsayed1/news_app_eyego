import 'package:flutter/material.dart';
import 'package:news_app_eyego/Core/routing/routes.dart';
import 'package:news_app_eyego/Features/home/ui/views/home_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) =>  HomeScreen(),
        );
    }
    return null;
  }
}
