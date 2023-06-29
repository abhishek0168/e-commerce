import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view_model/sign_in_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoogleIconButton extends StatelessWidget {
  const GoogleIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final signInpageModel = Provider.of<SignInPageViewModel>(context);
    return IconButton(
      onPressed: () {
        signInpageModel.signInWithGoogle();
      },
      icon: Container(
        width: 70,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 0.8,
              color: AppColors.grayColor,
            ),
          ],
        ),
        child: Image.asset('assets/images/icons8-google-48.png'),
      ),
    );
  }
}
