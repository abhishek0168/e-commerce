import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view_model/sign_in_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/view/sign_in_and_sign_up/textfield_widgets.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SignInPageViewModel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Sign up ',
              style: TextStyle(
                fontSize: 48,
              ),
            ),
            height20,
            height20,
            SignInTextField(
              label: 'Email',
              controller: controller.resetPasswordController,
            ),
            height20,
            FilledButton(
              onPressed: () {},
              style: const ButtonStyle(
                minimumSize: MaterialStatePropertyAll(
                  Size(double.infinity, 50),
                ),
              ),
              child: const Text(
                'RESET PASSWORD',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            height20,
            height20,
          ],
        ),
      ),
    );
  }
}
