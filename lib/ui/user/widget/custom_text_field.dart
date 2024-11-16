import 'package:flutter/material.dart';

import "../../../shared/theme.dart";

class CustomTextField extends StatelessWidget {
  final String titleText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool obscureText;
  final String? hintText;
  final String? errorText;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.titleText,
    required this.controller,
    required this.inputType,
    this.obscureText = false,
    this.validator,
    this.hintText,
    this.errorText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: blackTextStyle.copyWith(
              fontSize: 14,
              fontWeight: regular,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: inputType,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: greyTextStyle,
              errorText: errorText,
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
