import 'package:chat_up/Pages/WelcomePage.dart';
import 'package:chat_up/Pages/auth/page/LoginPage.dart';
import 'package:chat_up/Pages/auth/page/ProfileInfoPage.dart';
import 'package:chat_up/Pages/auth/page/VerificationPage.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String verification = 'verification';
  static const String userInfo = 'user-info';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (context) => WelcomePage());
      case login:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case verification:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(builder: (context) => VerificationPage(smsCodeId: args["smsCodeId"], phoneNumber: args["phoneNumber"],));
      case userInfo:
        return MaterialPageRoute(builder: (context) => ProfileInfoPage());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
