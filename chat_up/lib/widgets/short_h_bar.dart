import 'package:chat_up/core/theme/CustomThemeExtension.dart';
import 'package:flutter/material.dart';

class ShortHBar extends StatelessWidget {
  const ShortHBar({super.key, this.height, this.width, this.color});

  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 4,
      width: width ?? 25,
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: color ?? context.theme?.greyColor!.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
