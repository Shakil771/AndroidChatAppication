import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key, required this.icon, required this.onPressed, this.iconSize, this.minWidth, this.iconColor,
  });
  final IconData icon;
  final VoidCallback onPressed;
  final double? iconSize;
  final double? minWidth;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        splashColor: iconColor?? Colors.transparent,
        splashRadius: iconSize?? 32,
        iconSize:iconSize?? 32,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(minWidth: minWidth?? 0),
        icon: Icon(icon));
  }
}
