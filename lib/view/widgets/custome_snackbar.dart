import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:flutter/material.dart';

class CustomeSnackBar {
  SnackBar snackBar1(
      {required Color bgColor, required String content, Color? textColor}) {
    return SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: bgColor,
      content: Text(
        content,
        style: TextStyle(
          color: textColor ?? AppColors.blackColor,
        ),
      ),
      behavior: SnackBarBehavior.floating,
    );
  }
}
