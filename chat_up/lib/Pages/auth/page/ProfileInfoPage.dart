import 'dart:io';
import 'dart:typed_data';

import 'package:chat_up/Pages/auth/AuthController.dart';
import 'package:chat_up/Pages/auth/page/ImagePickerPage.dart';
import 'package:chat_up/core/helper/ShowAlertDialog.dart';
import 'package:chat_up/core/theme/Colors.dart';
import 'package:chat_up/core/theme/CustomThemeExtension.dart';
import 'package:chat_up/widgets/CustomElevatedButton.dart';
import 'package:chat_up/widgets/CustomIconButton.dart';
import 'package:chat_up/widgets/short_h_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/CustomTextField.dart';

class ProfileInfoPage extends ConsumerStatefulWidget {
  const ProfileInfoPage({
    super.key,
    this.profileImageUrl,
  });
  final String? profileImageUrl;

  @override
  ConsumerState<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends ConsumerState<ProfileInfoPage> {
  File? imageCamera;
  Uint8List? imageGallery;
  late TextEditingController usernameController;

  saveUserDataToFirebase() {
    String userName = usernameController.text;
    if (userName.isEmpty) {
      showAlertDialog(context: context, message: "Please enter your username");
    } else if (userName.length < 3 || userName.length > 25) {
      showAlertDialog(
          context: context,
          message: "Username must be between 3 and 20 characters.");
    }
    ref.read(authControllerProvider).saveUserInfoToFirestore(
          userName: userName,
          // profileImage: imageCamera ?? imageGallery ?? widget.profileImageUrl ??'',
          context: context,
          mounted: mounted,
        );
  }

  imagePickerTyBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: [
            ShortHBar(),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Profile photo",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                CustomIconButton(
                    icon: Icons.close, onPressed: () => Navigator.pop(context)),
              ],
            ),
            Divider(
              color: context.theme?.greyColor,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                imagePickerIcon(
                    onTap: picImageFromCamera,
                    icon: Icons.camera_alt_rounded,
                    text: "Camera"),
                SizedBox(
                  width: 15,
                ),
                imagePickerIcon(
                    onTap: () async {
                      Navigator.pop(context);
                      final image =
                          await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImagePickerPage(),
                      ));
                      if (image == null) return;
                      setState(() {
                        imageGallery = image;
                        imageCamera = null;
                      });
                    },
                    icon: Icons.photo_library,
                    text: "Gallery"),
              ],
            )
          ],
        );
      },
    );
  }

  picImageFromCamera() async {
    Navigator.of(context).pop();
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        imageCamera = File(image!.path);
        imageGallery = null;
      });
    } catch (e) {}
  }

  imagePickerIcon(
      {required VoidCallback onTap,
      required IconData icon,
      required String text}) {
    return Column(
      children: [
        CustomIconButton(
            icon: icon,
            iconColor: Coloors.greenDark,
            minWidth: 50,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            onPressed: onTap),
        SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: TextStyle(color: context.theme?.greyColor),
        )
      ],
    );
  }

  @override
  void initState() {
    usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
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
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: imagePickerTyBottomSheet,
              child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.theme?.photoIconBgColor,
                      border: Border.all(
                          color: imageCamera == null && imageGallery == null
                              ? Colors.transparent
                              : Colors.grey),
                      image: imageCamera != null ||
                              imageGallery != null ||
                              widget.profileImageUrl != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: imageGallery != null
                                  ? MemoryImage(imageGallery!) as ImageProvider
                                  : widget.profileImageUrl != null
                                      ? NetworkImage(widget.profileImageUrl!)
                                      : FileImage(imageCamera!) as ImageProvider,
                            )
                          : null),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 3, right: 3),
                    child: Icon(
                      Icons.add_a_photo_rounded,
                      size: 48,
                      color: imageCamera == null && imageGallery == null && widget.profileImageUrl==null
                          ? context.theme?.photoIconColor
                          : Colors.transparent,
                    ),
                  )),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomTextField(
                  controller: usernameController,
                  fontSize: 20,
                  hintText: "Enter your name",
                  autoFocus: true,
                  textAlign: TextAlign.left,
                  onChange: (value) {}),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomElevatedButton(
        onPressed: saveUserDataToFirebase,
        text: "NEXT",
        buttonWidth: 90,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
