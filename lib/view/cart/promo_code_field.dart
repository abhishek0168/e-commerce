import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:flutter/material.dart';

class PromoCodeField extends StatelessWidget {
  const PromoCodeField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: 'Enter your promo code',
        hintStyle: TextStyle(color: AppColors.grayColor),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        suffixIcon: IconButton.filled(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppColors.blackColor)),
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_forward,
            color: AppColors.whiteColor,
          ),
          iconSize: 30,
        ),
      ),
    );
  }
}
