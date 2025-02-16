import 'package:flutter/material.dart';

import '../core/theme/Colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonWidth,
  });
  final String text;
  final VoidCallback onPressed;
  final double? buttonWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: buttonWidth?? MediaQuery.of(context).size.width - 100,
        child: ElevatedButton(onPressed: onPressed,  child: Text(text)));
  }
}
