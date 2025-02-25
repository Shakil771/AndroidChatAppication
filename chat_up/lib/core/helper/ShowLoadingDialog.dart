import 'package:chat_up/core/theme/Colors.dart';
import 'package:chat_up/core/theme/CustomThemeExtension.dart';
import 'package:flutter/material.dart';

showLoadingDialog({
  required BuildContext context,
  required String message,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CircularProgressIndicator(
                  color: Coloors.greenDark,
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: context.theme?.greyColor,
                      fontSize: 15,
                      height: 1.5
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      );
    },
  );
}
