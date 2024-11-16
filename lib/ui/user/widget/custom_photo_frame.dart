import 'package:flutter/material.dart';

import "../../../shared/theme.dart";

class CustomPhotoFrame extends StatelessWidget {
  const CustomPhotoFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      margin: const EdgeInsets.only(right: 16, top: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultRadius),
        color: kGreyColor,
      ),
    );
  }
}
