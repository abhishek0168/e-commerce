import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/custome_snackBar.dart';
import 'package:ecommerce_app/view_model/sign_in_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SignInPageViewModel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Reset password',
                style: TextStyle(
                  fontSize: 48,
                ),
              ),
              height20,
              height20,
              Material(
                elevation: 1,
                child: TextFormField(
                  onChanged: (s) {
                    controller.isRestPasswordEnable();
                  },
                  controller: controller.resetPasswordController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    label: Text('Email'),
                    fillColor: AppColors.whiteColor,
                    filled: true,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (controller) {
                    String p =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                    RegExp regExp = RegExp(p);
                    if (regExp.hasMatch(controller!)) {
                      return null;
                    } else {
                      return 'Enter a valid email id';
                    }
                  },
                ),
              ),
              height20,
              Consumer<SignInPageViewModel>(
                builder: (context, value, child) => FilledButton(
                  onPressed: value.enableButton
                      ? () async {
                          if (_formKey.currentState!.validate()) {
                            String? message;
                            SnackBar snackBar;
                            message = await value.resetPassword(
                                value.resetPasswordController.text.trim(),
                                context);
                            if (message != null &&
                                message == 'mail-send' &&
                                context.mounted) {
                              snackBar = CustomeSnackBar().snackBar1(
                                bgColor: AppColors.starColor,
                                content: 'Password rest email sent',
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (message != null && context.mounted) {
                              snackBar = CustomeSnackBar().snackBar1(
                                bgColor: AppColors.primaryColor,
                                content: message,
                                textColor: AppColors.whiteColor,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            value.resetPasswordController.clear();

                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          }
                        }
                      : null,
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
              ),
              height20,
              height20,
            ],
          ),
        ),
      ),
    );
  }
}
