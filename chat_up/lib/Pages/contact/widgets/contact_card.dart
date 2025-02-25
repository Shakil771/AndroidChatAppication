import 'package:chat_up/core/theme/CustomThemeExtension.dart';
import 'package:flutter/material.dart';

import '../../../core/model/user_model.dart';
import '../../../core/theme/Colors.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.contactSource, required this.onTap,
  });

  final UserModel contactSource;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),
      dense: true,
      leading: CircleAvatar(
        backgroundColor:
        context.theme?.greyColor!.withAlpha(96),
        radius: 20,
        child: Icon(
          Icons.person,
          size: 30,
          color: Colors.white,
        ),
      ),
      title: Text(
        contactSource.userName,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: context.theme?.greyColor,
        ),
      ),
      subtitle: Text(
        "Hey there! I'm using ChatUp",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: context.theme?.greyColor,
        ),
      ),
      trailing: !contactSource.active? TextButton(
        onPressed:onTap,
        child: Text(
          "Invite",
          style: TextStyle(
            fontSize: 20,
            color: Coloors.greenLight,
            fontWeight: FontWeight.w600,
          ),
        ),
      ): null,
    );
  }
}
