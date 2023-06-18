import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/sign_in_and_sign_up/textfield_widgets.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view_model/sign_in_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key, required this.onClickSignIn});

  final formGlobalkey = GlobalKey<FormState>();
  final Function() onClickSignIn;
  @override
  Widget build(BuildContext context) {
    final signUpController = Provider.of<SignInPageViewModel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: formGlobalkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign up ',
                      style: TextStyle(
                        fontSize: 48,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SignInTextField(
                      label: 'Name',
                      controller: signUpController.signUpNameController,
                    ),
                    height10,
                    SignInTextField(
                      label: 'Email',
                      controller: signUpController.signUpEmailController,
                    ),
                    height10,
                    Consumer<SignInPageViewModel>(
                      builder: (context, value, child) => SignInPasswordField(
                        label: "Password",
                        viewModelController: value,
                        controller: value.signUpPasswordController,
                      ),
                    ),
                    height10,
                    Consumer<SignInPageViewModel>(
                      builder: (context, value, child) => Material(
                        elevation: 1,
                        child: TextFormField(
                          controller: value.signUpValidatePasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            label: Text('Confirm Password'),
                            fillColor: AppColors.whiteColor,
                            filled: true,
                          ),
                          validator: (signUpValidatePasswordController) =>
                              value.conformPassword(
                                  value.signUpValidatePasswordController.text),
                        ),
                      ),
                    ),
                    height20,
                    height20,
                    FilledButton(
                      onPressed: () async {
                        if (formGlobalkey.currentState!.validate()) {
                          String? message =
                              await signUpController.signUpPageAuth(
                            email: signUpController.signUpEmailController.text
                                .trim(),
                            password: signUpController
                                .signUpPasswordController.text
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
                            // creating account in database
                            await signUpController.createUser();

                            signUpController.signUpEmailController.clear();
                            signUpController.signUpPasswordController.clear();
                            signUpController.signUpNameController.clear();
                            signUpController.signUpValidatePasswordController
                                .clear();
                          }
                        }
                      },
                      style: const ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(
                          Size(double.infinity, 50),
                        ),
                      ),
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Alreadey have an Account ?'),
                        TextButton(
                            onPressed: () {
                              onClickSignIn();
                            },
                            child: const Text('Sign in'))
                      ],
                    ),
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
