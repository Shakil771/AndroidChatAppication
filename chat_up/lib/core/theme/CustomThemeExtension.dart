import 'package:flutter/material.dart';
import 'Colors.dart';

extension ExtendedTheme on BuildContext {
  CustomThemeExtension? get theme {
    return Theme.of(this).extension<CustomThemeExtension>();
  }
}

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  static final lightMode = CustomThemeExtension(
    photoIconBgColor: const Color(0xfb2b2f9),
    photoIconColor: const Color(0xff9daab3),
    circleImageColor: const Color(0xff25d366),
    greyColor: Color(0xff151010),
    blueColor: Coloors.blueLight,
    langBtnBgColor: const Color(0xfff7f8fa),
    langBtnHighlightColor: const Color(0xffe8e8ed),
    authAppBarTextColor: Coloors.greenLight,
  );

  static final darkMode = CustomThemeExtension(
    circleImageColor: Coloors.greenDark,
    greyColor: Coloors.greyDark,
    blueColor: Coloors.blueDark,
    langBtnBgColor: const Color(0xff182229),
    langBtnHighlightColor: const Color(0xff09141a),
    authAppBarTextColor: Coloors.greenDark,
    photoIconBgColor: const Color(0xff28339),
    photoIconColor: const Color(0xff61717b),
  );

  final Color? circleImageColor;
  final Color? greyColor;
  final Color? blueColor;
  final Color? langBtnBgColor;
  final Color? langBtnHighlightColor;
  final Color? authAppBarTextColor;
  final Color? photoIconBgColor;
  final Color? photoIconColor;

  // ✅ Remove the error-throwing constructor
  const CustomThemeExtension({
    this.circleImageColor,
    this.greyColor,
    this.blueColor,
    this.langBtnBgColor,
    this.langBtnHighlightColor,
    this.authAppBarTextColor,
    this.photoIconBgColor,
    this.photoIconColor,
  });

  // ✅ Implement `copyWith` method
  @override
  CustomThemeExtension copyWith({
    Color? circleImageColor,
    Color? greyColor,
    Color? blueColor,
    Color? langBtnBgColor,
    Color? langBtnHighlightColor,
    Color? authAppBarTextColor,
    Color? photoIconBgColor,
    Color? photoIconColor,
  }) {
    return CustomThemeExtension(
      circleImageColor: circleImageColor ?? this.circleImageColor,
      greyColor: greyColor ?? this.greyColor,
      blueColor: blueColor ?? this.blueColor,
      langBtnBgColor: langBtnBgColor ?? this.langBtnBgColor,
      photoIconBgColor: photoIconBgColor ?? this.photoIconBgColor,
      photoIconColor: photoIconColor ?? this.photoIconColor,
      langBtnHighlightColor:
          langBtnHighlightColor ?? this.langBtnHighlightColor,
      authAppBarTextColor: authAppBarTextColor ?? this.authAppBarTextColor,
    );
  }

  // ✅ Implement `lerp` (Linear interpolation for smooth transitions)
  @override
  CustomThemeExtension lerp(
      ThemeExtension<CustomThemeExtension>? other, double t) {
    if (other is! CustomThemeExtension) return this;

    return CustomThemeExtension(
      circleImageColor: Color.lerp(circleImageColor, other.circleImageColor, t),
      greyColor: Color.lerp(greyColor, other.greyColor, t),
      blueColor: Color.lerp(blueColor, other.blueColor, t),
      langBtnBgColor: Color.lerp(langBtnBgColor, other.langBtnBgColor, t),
      photoIconColor: Color.lerp(photoIconColor, other.photoIconColor, t),
      photoIconBgColor: Color.lerp(photoIconBgColor, other.photoIconBgColor, t),
      langBtnHighlightColor:
          Color.lerp(langBtnHighlightColor, other.langBtnHighlightColor, t),
      authAppBarTextColor:
          Color.lerp(authAppBarTextColor, other.authAppBarTextColor, t),
    );
  }
}
