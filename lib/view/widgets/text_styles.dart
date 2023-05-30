import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeTextStyle {
  static final mainHeadingWhite = GoogleFonts.alata(
    color: AppColors.whiteColor,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    shadows: [
      const Shadow(
        color: AppColors.blackColor,
        blurRadius: 1,
      ),
    ],
  );

  static final mainHeadingBlack =
      mainHeadingWhite.copyWith(color: AppColors.blackColor, shadows: []);

  static final productName = GoogleFonts.alata(
    color: AppColors.blackColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}
