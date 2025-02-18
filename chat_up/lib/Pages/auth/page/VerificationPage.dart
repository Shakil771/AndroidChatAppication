import 'package:chat_up/Pages/auth/AuthController.dart';
import 'package:chat_up/Pages/auth/widgets/CustomTextField.dart';
import 'package:chat_up/core/theme/CustomThemeExtension.dart';
import 'package:chat_up/widgets/CustomElevatedButton.dart';
import 'package:chat_up/widgets/CustomIconButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerificationPage extends ConsumerWidget {
  const VerificationPage(
      {super.key, required this.smsCodeId, required this.phoneNumber});
  final String smsCodeId;
  final String phoneNumber;

  void verifySmsCode(BuildContext context, WidgetRef ref, String smsCode) {
    ref.read(authControllerProvider).verifySmsCode(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Verify your phone number",
          style: TextStyle(
              color: context.theme?.authAppBarTextColor, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          CustomIconButton(
            icon: Icons.more_vert,
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(
                        color: context.theme?.greyColor,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "You've tried to register +880 9638837771. before requesting an SMS or call with your verification code. ",
                        ),
                        TextSpan(
                            text: "Wrong number?",
                            style: TextStyle(color: context.theme?.blueColor)),
                      ]),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: CustomTextField(
                fontSize: 30,
                hintText: "- - - - - -",
                autoFocus: true,
                keyboardType: TextInputType.number,
                onChange: (value) {
                  if(value.length == 6){
                    return verifySmsCode(context, ref, value);
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Enter 6-digit code",
              style: TextStyle(color: context.theme?.greyColor),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                child: Center(
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            size: 15,
                            Icons.message,
                            color: context.theme?.greyColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Resend SMS",
                            style: TextStyle(
                                color: context.theme?.greyColor!
                                    .withValues(alpha: 100)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("or"),
                      ),
                      Row(
                        children: [
                          Icon(
                            size: 15,
                            Icons.call,
                            color: context.theme?.greyColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Call me",
                            style: TextStyle(
                                color: context.theme?.greyColor!
                                    .withValues(alpha: 100)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomElevatedButton(
        onPressed: () {},
        text: "NEXT",
        buttonWidth: 90,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
