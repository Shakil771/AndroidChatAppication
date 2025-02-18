import 'package:chat_up/core/theme/CustomThemeExtension.dart';
import 'package:chat_up/widgets/PrivacyAndTerms.dart';
import 'package:flutter/material.dart';

import '../routes/Routes.dart';
import '../widgets/CustomElevatedButton.dart';
import '../widgets/LanguageButton.dart';

class WelcomePage extends StatelessWidget {
  navigateToLoginPage(context){
    Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (route)=>false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 50.0),
              child: Container(
                  child: Image.asset(
                'assets/images/circle.png',
                color: context.theme?.circleImageColor,
              )),
            ),
          )),
          SizedBox(
            height: 40,
          ),
          Expanded(
              child: Column(
            children: [
              Text(
                "Welcome to ChatUp",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const PrivacyAndTerms(),
              CustomElevatedButton(
                text: "AGREE AND CONTINUE",
                onPressed: ()=> navigateToLoginPage(context),
              ),
              SizedBox(
                height: 50,
              ),
              LanguageButton()
            ],
          )),
        ],
      ),
    );
  }
}
