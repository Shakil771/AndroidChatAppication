import 'package:chat_up/core/theme/CustomThemeExtension.dart';
import 'package:flutter/material.dart';


class PrivacyAndTerms extends StatelessWidget {
  const PrivacyAndTerms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 20, horizontal: 30.0),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "Read our ",
              style: TextStyle(
                  color: context.theme?.greyColor,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: "Privacy policy ",
                  style: TextStyle(
                      color: context.theme?.blueColor,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                    text: 'Tap "Agree and continue" to accept the '),
                TextSpan(
                  text: 'Terms of Services.',
                  style: TextStyle(
                      color: context.theme?.blueColor,
                      fontWeight: FontWeight.bold),
                )
              ])),
    );
  }
}
