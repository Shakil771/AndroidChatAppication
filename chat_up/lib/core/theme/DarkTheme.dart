import 'package:chat_up/core/theme/Colors.dart'; // Ensure correct case in file name
import 'package:chat_up/core/theme/CustomThemeExtension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      scaffoldBackgroundColor: Coloors.backgroundDark, // ✅ This is correct
      colorScheme: base.colorScheme.copyWith(
        surface:
            Coloors.backgroundDark, // ✅ Use `surface` instead of `background`
      ),
      extensions: [CustomThemeExtension.darkMode],
      appBarTheme: AppBarTheme(
        backgroundColor: Coloors.greyBackground,
        titleTextStyle: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Coloors.greyDark),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light),
      ),

      iconTheme: IconThemeData(
        color: Coloors.greyDark,
      ),
      tabBarTheme: TabBarThemeData(
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Coloors.greenDark, width: 2)),
        unselectedLabelColor: Coloors.greyDark,
        labelColor: Coloors.greyDark
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Coloors.greenDark,
            foregroundColor: Coloors.backgroundDark,
            splashFactory: NoSplash.splashFactory,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            shadowColor: Colors.transparent),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Coloors.greyBackground,
          modalBackgroundColor: Coloors.greyBackground,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)))),
      dialogBackgroundColor: Coloors.greyBackground,
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ));
}
