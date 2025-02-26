import 'package:chat_up/core/theme/Colors.dart'; // Ensure correct case in file name
import 'package:chat_up/core/theme/CustomThemeExtension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      scaffoldBackgroundColor: Coloors.backgroundLight, // ✅ This is correct
      colorScheme: base.colorScheme.copyWith(
        surface:
            Coloors.backgroundLight, // ✅ Use `surface` instead of `background`
      ),
      extensions: [CustomThemeExtension.lightMode],
      appBarTheme: AppBarTheme(
        backgroundColor: Coloors.greenLight,
        titleTextStyle: TextStyle(fontSize: 20),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Coloors.greenLight,
          foregroundColor: Coloors.backgroundLight,
          splashFactory: NoSplash.splashFactory,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      tabBarTheme: TabBarThemeData(
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.white, width: 3)),
        unselectedLabelColor: Color(0xffb3d9d2),
        labelColor: Color(0xffb3d9d2)

      ),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Coloors.backgroundLight,
          modalBackgroundColor: Coloors.backgroundLight,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)))),
      dialogBackgroundColor: Coloors.backgroundLight,
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ));
}
