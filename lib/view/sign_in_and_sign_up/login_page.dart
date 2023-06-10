import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/main_page/main_page.dart';
import 'package:ecommerce_app/view/sign_in_and_sign_up/textfield_widgets.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view_model/sign_in_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final formGlobalKey = GlobalKey<FormState>();
  final String tempUser = 'abhi';
  final String tempPassword = 'Abhi!@#123';
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
                      'Login ',
                      style: TextStyle(
                        fontSize: 48,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Consumer<SignInPageViewModel>(
                      builder: (context, value, child) => SignInTextField(
                        label: 'Name',
                        controller: viewModelController.nameController,
                      ),
                    ),
                    height10,
                    Consumer<SignInPageViewModel>(
                      builder: (context, value, child) => SignInPasswordField(
                        viewModelController: value,
                        controller: value.passwordController,
                      ),
                    ),
                    height20,
                    height20,
                    FilledButton(
                      onPressed: () {
                        if (formGlobalKey.currentState!.validate()) {
                          if (viewModelController.passwordController.text ==
                                  tempPassword &&
                              viewModelController.nameController.text ==
                                  tempUser) {
                            // navigation here
                          } else {
                            const snackBar = SnackBar(
                              backgroundColor: AppColors.primaryColor,
                              content: Text(
                                'Wrong username or password',
                                style: TextStyle(color: AppColors.whiteColor),
                              ),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ),
                        );
                      },
                      style: const ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(
                          Size(double.infinity, 50),
                        ),
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        TextButton(
                            onPressed: () {}, child: const Text('Sign up')),
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
