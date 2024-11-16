import "package:flutter/material.dart";

import "../shared/theme.dart";

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final Function() onPressed;
  final EdgeInsets margin;
  final Color backGroundColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.width,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
    this.backGroundColor = kPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 55,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultRadius),
        color: backGroundColor,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
