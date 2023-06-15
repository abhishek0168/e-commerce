import 'package:flutter/material.dart';

Widget threeDotLoadingAnimation() {
  return Center(
    child: Image.asset(
      'assets/images/rive_loading.gif',
      width: 80,
      height: 80,
      fit: BoxFit.cover,
    ),
  );
}
