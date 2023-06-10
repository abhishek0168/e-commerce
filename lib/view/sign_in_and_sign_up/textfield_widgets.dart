import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view_model/sign_in_page_viewmodel.dart';
import 'package:flutter/material.dart';

class SignInPasswordField extends StatelessWidget {
  const SignInPasswordField({
    super.key,
    required this.controller,
    required this.viewModelController,
  });

  final SignInPageViewModel viewModelController;

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      child: TextFormField(
        controller: controller,
        obscureText: viewModelController.displayPassword,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                viewModelController.changeDisplayPassword();
              },
              icon: viewModelController.displayPassword
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off)),
          border: InputBorder.none,
          label: const Text('Password'),
          fillColor: AppColors.whiteColor,
          filled: true,
        ),
        validator: (controller) =>
            viewModelController.validatePassword(controller),
      ),
    );
  }
}

class SignInTextField extends StatelessWidget {
  const SignInTextField({
    super.key,
    required this.label,
    required this.controller,
  });
  final String label;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          label: Text(label),
          fillColor: AppColors.whiteColor,
          filled: true,
        ),
        validator: (controller) {
          if (controller == null || controller.isEmpty) {
            return 'Fill this field';
          }
          return null;
        },
      ),
    );
  }
}
