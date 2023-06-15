import 'package:ecommerce_app/services/user_auth.dart';
import 'package:flutter/material.dart';

class SignInPageViewModel extends ChangeNotifier {
  // signin page
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // signup page
  final signUpNameController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final signUpValidatePasswordController = TextEditingController();
  final signUpEmailController = TextEditingController();

  // password reset page
  final resetPasswordController = TextEditingController();

  bool displayPassword = true;

  changeDisplayPassword() {
    displayPassword = !displayPassword;
    notifyListeners();
  }

  String? validatePassword(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  String? conformPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else {
      if (signUpPasswordController.text.trim() !=
          signUpValidatePasswordController.text.trim()) {
        return 'Your password and confirmation password do not match.';
      } else {
        return null;
      }
    }
  }

  final firebseUserAuth = UserAuthFirebase();

  Future<String?> signInPageAuth({
    required String email,
    required String password,
  }) async {
    String? error =
        await firebseUserAuth.signIn(email: email, password: password);
    return error;
  }

  Future<String?> signUpPageAuth({
    required String email,
    required String password,
  }) async {
    String? error =
        await firebseUserAuth.createUser(email: email, password: password);
    return error;
  }

  Future<void> signOutUser() async {
    await firebseUserAuth.signOut();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    signUpNameController.dispose();
    signUpPasswordController.dispose();
    signUpValidatePasswordController.dispose();
    signUpEmailController.dispose();
    resetPasswordController.dispose();
    super.dispose();
  }
}
