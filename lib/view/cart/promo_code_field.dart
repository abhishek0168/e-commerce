import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/custome_snackbar.dart';
import 'package:ecommerce_app/view_model/promo_code_viewmodel.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromoCodeField extends StatelessWidget {
  const PromoCodeField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    final promoCodeController = Provider.of<PromoCodeViewModel>(context);
    final userDetailsController = Provider.of<UserDetailsViewModel>(context);

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
          onPressed: () {
            String message = '';
            if (userDetailsController.isPromoCodeUsed) {
              userDetailsController.removePromoCode();
              message = 'Promo code removed';
            } else {
              message = userDetailsController.checkPromoCode(
                  promoCodeController.promoCodeKeyController.text.trim(),
                  userDetailsController.userData!.id,
                  promoCodeController.promoCodes);
            }
            final snackBar = CustomeSnackBar()
                .snackBar1(bgColor: AppColors.starColor, content: message);

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
          },
          icon: userDetailsController.isPromoCodeUsed
              ? const Icon(
                  Icons.clear,
                  color: AppColors.whiteColor,
                )
              : const Icon(
                  Icons.arrow_forward,
                  color: AppColors.whiteColor,
                ),
          iconSize: 30,
        ),
      ),
    );
  }
}
