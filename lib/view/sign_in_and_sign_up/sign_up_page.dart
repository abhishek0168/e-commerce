import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/sign_in_and_sign_up/login_page.dart';
import 'package:ecommerce_app/view/sign_in_and_sign_up/textfield_widgets.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view_model/sign_in_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final formGlobalkey = GlobalKey<FormState>();

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
                      onPressed: () {
                        if (formGlobalkey.currentState!.validate()) {
                          signUpController.signUpPageAuth(email: signUpController.signUpEmailController.text.trim(), password:signUpController.signUpPasswordController.text.trim());
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginInPage(),
                                ),
                              );
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
