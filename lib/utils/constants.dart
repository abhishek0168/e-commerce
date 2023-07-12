
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/three_dot_loading.dart';
import 'package:flutter/material.dart';

/* sized box */
const height20 = SizedBox(height: 20);
const height10 = SizedBox(height: 10);
const width10 = SizedBox(width: 10);
const width20 = SizedBox(width: 20);

/* main page text */
const home = 'Home';
const shop = 'Shop';
const fav = 'Favorites';
const profile = 'Profile';
const bag = 'Bag';

/* padding */
const paddingVertical10 = EdgeInsets.symmetric(vertical: 10);


/* loading idicator */
  Future<dynamic> loadingIdicator(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => threeDotLoadingAnimation(),
      barrierColor: AppColors.whiteColor.withOpacity(0.5),
    );
  }

