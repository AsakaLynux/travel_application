import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

const double defaultRadius = 17.0;

const Color kPrimaryColor = Color(0xff5C40CC);
const Color kBlackColor = Color(0xff1F1449);
const Color kWhiteColor = Color(0xffFFFFFF);
const Color kGreyColor = Color(0xff9698A9);
const Color kGreenColor = Color(0xff0EC3AE);
const Color kRedColor = Color(0xffEB70A5);
const Color kBackgroundColor = Color(0xffFAFAFA);
const Color kInactiveColor = Color(0xffDBD7EC);
const Color kTransparentColor = Colors.transparent;
const Color kUnavailableColor = Color(0xffEBECF1);
const Color kAvailableColor = Color(0xffE0D9FF);

TextStyle blackTextStyle = GoogleFonts.poppins(
  color: kBlackColor,
);
TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: kWhiteColor,
);
TextStyle greyTextStyle = GoogleFonts.poppins(
  color: kGreyColor,
);
TextStyle greenTextStyle = GoogleFonts.poppins(
  color: kGreenColor,
);
TextStyle redTextStyle = GoogleFonts.poppins(
  color: kRedColor,
);
TextStyle purpleTextStyle = GoogleFonts.poppins(
  color: kPrimaryColor,
);

const FontWeight light = FontWeight.w300;
const FontWeight regular = FontWeight.w400;
const FontWeight medium = FontWeight.w500;
const FontWeight semiBold = FontWeight.w600;
const FontWeight bold = FontWeight.w700;
const FontWeight extraBold = FontWeight.w800;
const FontWeight black = FontWeight.w900;

final formatRupiah =
    NumberFormat.currency(locale: "id_ID", symbol: "IDR ", decimalDigits: 0);
