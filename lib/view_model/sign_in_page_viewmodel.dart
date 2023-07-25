import 'dart:developer';

import 'package:ecommerce_app/model/user_model/user_model.dart';
import 'package:ecommerce_app/services/user_auth.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view_model/user_address_viewmodel.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  bool enableButton = false;
  bool displayPassword = true;

  // Auth page
  bool isLogin = true;

  // instances
  final userDetailsModel = UserDetailsViewModel();
  final firebseUserAuth = UserAuthFirebase();
  final addressViewModel = AddressViewModel();

  void toggle() {
    isLogin = !isLogin;
    notifyListeners();
    log(isLogin.toString());
  }

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

  Future<String?> signInPageAuth({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    String? message = await firebseUserAuth.signIn(
      email: email,
      password: password,
    );
    await userDetailsModel.fetchingUserData();
    await addressViewModel.getUserAddress();
    notifyListeners();
    return message;
  }

  Future<String?> signUpPageAuth({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    String? message =
        await firebseUserAuth.createUser(email: email, password: password);
    await userDetailsModel.fetchingUserData();
    await addressViewModel.getUserAddress();

    return message;
  }

  Future<void> signOutUser() async {
    await firebseUserAuth.signOut();
    await GoogleSignIn().signOut();
  }

  Future<void> createUser() async {
    final userData = UserModel(
      id: '',
      userName: signUpNameController.text.trim(),
      userEmail: signUpEmailController.text.trim(),
      userPassword: signUpPasswordController.text.trim(),
    );

    await firebseUserAuth.addUserToDatabase(userData);
  }

  Future<void> signInWithGoogle() async {
    await firebseUserAuth.signInWithGoogle();
    notifyListeners();
  }

  Future<bool> verifyEmail() async {
    bool status = await firebseUserAuth.emailVerification();
    return status;
  }

  void isRestPasswordEnable() {
    if (resetPasswordController.text.trim().isNotEmpty) {
      enableButton = true;
    } else {
      enableButton = false;
    }
    notifyListeners();
  }

  Future<String?> resetPassword(String email, BuildContext context) async {
    String? message;
    loadingIdicator(context);
    message = await firebseUserAuth.resetUserPassword(email: email);
    if (context.mounted) {
      Navigator.pop(context);
    }
    return message;
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
