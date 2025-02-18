import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key, required this.icon, required this.onPressed, this.iconSize, this.minWidth, this.iconColor, this.border, this.background,
  });
  final IconData icon;
  final VoidCallback onPressed;
  final double? iconSize;
  final double? minWidth;
  final Color? iconColor;
  final BoxBorder? border;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: border
      ),
      child: IconButton(
          onPressed: onPressed,
          splashColor: iconColor?? Colors.transparent,
          splashRadius: (minWidth ?? (iconSize?? 32))-25,
          iconSize: iconSize?? 32,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(minWidth: minWidth?? 0, minHeight: minWidth?? 0,),
          icon: Icon(icon)),
    );
  }
}
