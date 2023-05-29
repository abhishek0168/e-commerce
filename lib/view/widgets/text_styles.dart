import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/theme/app_font_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeTextStyle {
  static final textHeadingWhite = GoogleFonts.alata(
    color: AppColors.whiteColor,
    fontSize: AppFontSize.mainHeading,
    fontWeight: FontWeight.bold,
    shadows: [
      const Shadow(
        color: AppColors.blackColor,
        // blurRadius: 1,
      ),
    ],
  );
}
