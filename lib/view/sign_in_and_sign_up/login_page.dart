import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/sign_in_and_sign_up/password_reset.dart';
import 'package:ecommerce_app/view/sign_in_and_sign_up/textfield_widgets.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view_model/sign_in_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key, required this.onClickSignIn});
  final formGlobalKey = GlobalKey<FormState>();
  final Function() onClickSignIn;
  @override
  Widget build(BuildContext context) {
    final viewModelController =
        Provider.of<SignInPageViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: formGlobalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 48,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Consumer<SignInPageViewModel>(
                      builder: (context, value, child) => SignInTextField(
                        label: 'Email',
                        controller: viewModelController.emailController,
                      ),
                    ),
                    height10,
                    Consumer<SignInPageViewModel>(
                      builder: (context, value, child) => SignInPasswordField(
                        label: "Password",
                        viewModelController: value,
                        controller: value.passwordController,
                      ),
                    ),
                    height20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ResetPassword(),
                              ),
                            );
                          },
                          child: const Row(
                            children: [
                              Text('Forgot password ?'),
                              width10,
                              Icon(
                                Icons.arrow_right_alt,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    height20,
                    FilledButton(
                      onPressed: () async {
                        if (formGlobalKey.currentState!.validate()) {
                          String? message =
                              await viewModelController.signInPageAuth(
                            email:
                                viewModelController.emailController.text.trim(),
                            password: viewModelController
                                .passwordController.text
                                .trim(),
                          );

                          if (message != null && context.mounted) {
                            final snackBar = SnackBar(
                              backgroundColor: AppColors.primaryColor,
                              content: Text(
                                message,
                                style: const TextStyle(
                                    color: AppColors.whiteColor),
                              ),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            viewModelController.emailController.clear();
                            viewModelController.passwordController.clear();
                          }
                        }
                      },
                      style: const ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(
                          Size(double.infinity, 50),
                        ),
                      ),
                      child: Text(
                        'Sign in'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        TextButton(
                            onPressed: () {
                              viewModelController.emailController.clear();
                              viewModelController.passwordController.clear();
                              onClickSignIn();
                            },
                            child: const Text('Sign up')),
                      ],
                    ),
                    height20,
                    height20,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(child: Divider()),
                        Flexible(child: Text('OR')),
                        Flexible(child: Divider()),
                      ],
                    ),
                    height20,
                    height20,
                    IconButton(
                      onPressed: () {},
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
                        child:
                            Image.asset('assets/images/icons8-google-48.png'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
