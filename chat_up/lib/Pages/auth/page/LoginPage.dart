import 'package:chat_up/Pages/auth/AuthController.dart';
import 'package:chat_up/Pages/auth/widgets/CustomTextField.dart';
import 'package:chat_up/core/helper/ShowAlertDialog.dart';
import 'package:chat_up/core/theme/Colors.dart';
import 'package:chat_up/core/theme/CustomThemeExtension.dart';
import 'package:chat_up/widgets/CustomElevatedButton.dart';
import 'package:chat_up/widgets/CustomIconButton.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final TextEditingController countryNameController;
  late final TextEditingController countryCodeController;
  late final TextEditingController phoneNumberController;

  showCountryCodePicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: ['ET', 'US', 'IN'],
      countryListTheme: CountryListThemeData(
          bottomSheetHeight: 500,
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          flagSize: 25,
          borderRadius: BorderRadius.circular(20),
          textStyle: TextStyle(color: context.theme?.greyColor),
          inputDecoration: InputDecoration(
            labelStyle: TextStyle(color: context.theme?.greyColor),
            prefixIcon: Icon(
              Icons.language,
              color: Coloors.greenDark,
            ),
            hintText: "Search country code or name",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.theme!.greyColor!
                    .withValues(alpha: 100), // Adjust color as needed
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Coloors.greenDark, // Adjust color as needed
              ),
            ),
          )),
      onSelect: (country) {
        countryNameController.text = country.name;
        countryCodeController.text = country.phoneCode;
      },
    );
  }

  sendCodeToPhone() {
    final phoneNumber = phoneNumberController.text;
    final countryName = countryNameController.text;
    final countryCode = countryCodeController.text;

    if (phoneNumber.isEmpty) {
      return showAlertDialog(
        context: context,
        message: "Please enter your phoneNumber number",
      );
    } else if (phoneNumber.length < 8) {
      return showAlertDialog(
        context: context,
        message:
            "The phoneNumber number you entered is too short for the country: $countryName. \n\n\nInclude your area code if you haven't ",
      );
    } else if (phoneNumber.length > 15) {
      return showAlertDialog(
        context: context,
        message:
            "The phoneNumber number you entered is too long for the country: $countryName.",
      );
    }
    //request a verification code
    ref
        .read(authControllerProvider)
        .sendSmsCode(context: context, phoneNumber: phoneNumber);
  }

  @override
  void initState() {
    countryNameController = TextEditingController(text: "Bangladesh");
    countryCodeController = TextEditingController(text: "880");
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countryNameController.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Enter your phone number",
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "ChatUp will need to verify your phone number ",
                  style:
                      TextStyle(color: context.theme?.greyColor, height: 1.5),
                  children: [
                    TextSpan(
                      text: "What's my number? ",
                      style: TextStyle(
                          color: context.theme?.blueColor, height: 1.5),
                    )
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: CustomTextField(
              controller: countryNameController,
              onTap: showCountryCodePicker,
              readOnly: true,
              suffixIcon: const Icon(
                Icons.arrow_drop_down,
                color: Coloors.greenDark,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: CustomTextField(
                    controller: countryCodeController,
                    onTap: showCountryCodePicker,
                    readOnly: true,
                    prefixText: "+",
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: CustomTextField(
                  controller: phoneNumberController,
                  onTap: () {},
                  hintText: "phone number",
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.number,
                ))
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Carrier charges may apply",
            style: TextStyle(color: context.theme?.greyColor),
          )
        ],
      ),
      floatingActionButton: CustomElevatedButton(
        onPressed: sendCodeToPhone,
        text: "NEXT",
        buttonWidth: 90,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
