import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import "../shared/theme.dart";

class CustomTextField extends StatelessWidget {
  final String titleText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool obscureText;
  final String? hintText;
  final String? errorText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;

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
    this.inputFormatters,
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
            inputFormatters: inputFormatters,
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
