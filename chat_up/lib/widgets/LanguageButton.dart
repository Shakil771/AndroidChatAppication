import 'package:chat_up/core/theme/CustomThemeExtension.dart';
import 'package:chat_up/widgets/CustomIconButton.dart';
import 'package:flutter/material.dart';

import '../core/theme/Colors.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key,
  });
  showBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  width: 30,
                  decoration: BoxDecoration(
                      color: context.theme!.greyColor!.withValues(alpha: 128),
                      borderRadius: BorderRadius.circular(5)),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CustomIconButton(
                        onPressed: () =>Navigator.of(context).pop(),
                        icon: Icons.close_outlined,
                        minWidth: 40,
                    ),

                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "App Language",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: context.theme!.greyColor!.withValues(alpha: 128),
                  thickness: 0.5,
                ),
                RadioListTile(
                  value: true,
                  groupValue: true,
                  onChanged: (value) {},
                  activeColor: Coloors.greenDark,
                  title: Text("English"),
                  subtitle: Text(
                    "(phone's language)",
                    style: TextStyle(color: context.theme?.greyColor),
                  ),
                ),
                RadioListTile(
                  value: true,
                  groupValue: true,
                  onChanged: (value) {},
                  activeColor: Coloors.greenDark,
                  title: Text("Bengali"),
                  subtitle: Text(
                    "(Bangladesh)",
                    style: TextStyle(color: context.theme?.greyColor),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xff182229),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          return showBottomSheet(context);
        },
        borderRadius: BorderRadius.circular(20),
        splashFactory: NoSplash.splashFactory,
        highlightColor: Color(0xff09141a),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.language, color: Coloors.greenDark),
              SizedBox(
                width: 10,
              ),
              Text(
                "English",
                style: TextStyle(color: Coloors.greenDark),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Coloors.greenDark,
              )
            ],
          ),
        ),
      ),
    );
  }
}
