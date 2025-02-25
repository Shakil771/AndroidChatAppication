import 'package:chat_up/Pages/WelcomePage.dart';
import 'package:chat_up/Pages/auth/page/LoginPage.dart';
import 'package:chat_up/Pages/auth/page/ProfileInfoPage.dart';
import 'package:chat_up/Pages/auth/page/VerificationPage.dart';
import 'package:chat_up/Screens/ChatScreen.dart';
import 'package:chat_up/Screens/ContactScreen.dart';
import 'package:chat_up/Screens/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../core/model/user_model.dart';

class Routes {
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String verification = 'verification';
  static const String userInfo = 'user-info';
  static const String home = 'home';
  static const String contact = 'contact';
  static const String chat = 'chat';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(
          builder: (context) => WelcomePage(),
        );
      case login:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case verification:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => VerificationPage(
            smsCodeId: args["smsCodeId"],
            phoneNumber: args["phoneNumber"],
          ),
        );
      case userInfo:
        final String? profileImageUrl = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (context) => ProfileInfoPage(
            profileImageUrl: profileImageUrl,
          ),
        );
      case home:
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );
      case contact:
        return MaterialPageRoute(
          builder: (context) => ContactPage(),
        );
      case chat:
        final UserModel user = settings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (context) => ChatPage(user: user,),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
