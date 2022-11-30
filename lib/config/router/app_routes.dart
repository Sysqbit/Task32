import 'package:flutter/material.dart';
import 'package:sysqbit_todo/ui/pages/home_page.dart';
import 'package:sysqbit_todo/ui/pages/login_page.dart';
import 'package:sysqbit_todo/ui/pages/new_task_page.dart';

import '../../ui/pages/theme_page.dart';

class AppRouter {
  static const String themePage = "/";
  static const String homePage = "/home";
  static const String loginPage = "/login";
  static const String newTaskPage = "/new-task";

  AppRouter._();

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case themePage:
        return MaterialPageRoute(builder: ((context) => const ThemePage()));

      case homePage:
        return MaterialPageRoute(builder: ((context) => const HomePage()));
      case loginPage:
        return MaterialPageRoute(builder: ((context) => const LoginPage()));
      case newTaskPage:
        return MaterialPageRoute(builder: ((context) => const NewTaskPage()));

      default:
        throw const FormatException("Route not found");
    }
  }
}
