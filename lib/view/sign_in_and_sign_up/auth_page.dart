import 'package:ecommerce_app/view/sign_in_and_sign_up/login_page.dart';
import 'package:ecommerce_app/view/sign_in_and_sign_up/sign_up_page.dart';
import 'package:ecommerce_app/view_model/sign_in_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SignInPageViewModel>(context);
    return controller.isLogin
        ? LogInPage(onClickSignIn: controller.toggle)
        : SignUpPage(onClickSignIn: controller.toggle);
  }
}
