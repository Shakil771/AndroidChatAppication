import 'package:chat_up/core/theme/CustomThemeExtension.dart';
import 'package:chat_up/widgets/CustomElevatedButton.dart';
import 'package:flutter/material.dart';

import 'widgets/CustomTextField.dart';

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({super.key});

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  late TextEditingController  nameController;
  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Info",
          style: TextStyle(
            color: context.theme?.authAppBarTextColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          children: [
            Text(
              "Please provide your name and an optional profile photo",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.theme?.greyColor,
              ),
            ),
            SizedBox(height: 40,),
            Container(
              padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.theme?.photoIconBgColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3, right: 3),
                  child: Icon(Icons.add_a_photo_rounded, size: 48,color: context.theme?.photoIconColor,),
                )
            ),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomTextField(
                controller: nameController,
                fontSize: 20,
                hintText: "Enter your name",
                autoFocus: true,
                textAlign: TextAlign.left,
                onChange: (value) {}
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomElevatedButton(
        onPressed: (){},
        text: "NEXT",
        buttonWidth: 90,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
