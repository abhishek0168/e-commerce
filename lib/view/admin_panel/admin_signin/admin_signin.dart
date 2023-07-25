import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/widgets/custom_submit_button.dart';
import 'package:ecommerce_app/view/widgets/text_styles.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminSignIn extends StatelessWidget {
  const AdminSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final userModel = context.read<UserDetailsViewModel>();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Admin',
                style: CustomeTextStyle.mainHeadingBlack,
              ),
              height20,
              TextFormField(
                controller: userModel.adminEmailController,
                decoration: const InputDecoration(
                  label: Text('Email'),
                ),
              ),
              height10,
              TextFormField(
                controller: userModel.adminPasswordController,
                decoration: const InputDecoration(
                  label: Text('Email'),
                ),
                obscureText: true,
                obscuringCharacter: '*',
              ),
              height20,
              CustomSubmitButton(
                  screenSize: screenSize,
                  title: 'sign in',
                  onPress: () async {
                    await userModel.onAdminSignIn(
                      userModel.adminPasswordController.text.trim(),
                      userModel.adminEmailController.text.trim(),
                      context,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
