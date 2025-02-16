import 'package:chat_up/core/theme/Colors.dart';
import 'package:chat_up/core/theme/CustomThemeExtension.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.controller,
      this.hintText,
      this.readOnly,
      this.textAlign,
      this.keyboardType,
      this.prefixText,
      this.onTap,
      this.suffixIcon,
      this.onChange,
      this.fontSize,
      this.autoFocus});

  final TextEditingController? controller;
  final String? hintText;
  final bool? readOnly;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final String? prefixText;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Function(String)? onChange;
  final double? fontSize;
  final bool? autoFocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly ?? false,
      textAlign: textAlign ?? TextAlign.center,
      keyboardType: readOnly == null ? keyboardType : null,
      style: TextStyle(fontSize: fontSize),
      autofocus: autoFocus?? false,
      onChanged: onChange,
      decoration: InputDecoration(
          isDense: true,
          prefixText: prefixText,
          suffix: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyle(color: context.theme?.greyColor),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Coloors.greenDark)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Coloors.greenDark, width: 2))),
    );
  }
}
