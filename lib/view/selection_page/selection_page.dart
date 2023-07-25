import 'package:ecommerce_app/view/admin_panel/admin_signin/admin_signin.dart';
import 'package:ecommerce_app/view/admin_panel/product_page/admin_product_diplaying_page.dart';
import 'package:ecommerce_app/view/mail_verification_page/mail_verification_page.dart';
import 'package:ecommerce_app/view/sign_in_and_sign_up/Auth_page.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/waiting_page.dart';
import 'package:ecommerce_app/view_model/product_data_from_firebase.dart';
import 'package:ecommerce_app/view_model/sign_in_page_viewmodel.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataFromFirebase = Provider.of<DataFromFirebase>(context);
    final userViewModel = Provider.of<UserDetailsViewModel>(context);
    final authController = Provider.of<SignInPageViewModel>(context);
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                InkWell(
                  splashColor: AppColors.primaryColor,
                  onTap: () async {
                    await dataFromFirebase.callPrductDetails();
                    if (userViewModel.isAdminSignIn) {
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminDisplayPage(),
                          ),
                        );
                      }
                    } else {
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminSignIn(),
                          ),
                        );
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 5),
                    width: (screenSize.width / 2) - 15,
                    height: (screenSize.width / 2) - 15,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.computer,
                        ),
                        Text(
                          'Admin',
                          style: TextStyle(
                            color: AppColors.blackColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await dataFromFirebase.callPrductDetails();
                    await userViewModel.fetchingUserData();
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StreamBuilder<User?>(
                            stream: FirebaseAuth.instance.authStateChanges(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const WaitingPage();
                              } else if (snapshot.connectionState ==
                                  ConnectionState.none) {
                                return const Center(
                                  child: Text('Somthing went wrong !'),
                                );
                              } else if (snapshot.hasError) {
                                return const Center(
                                  child: Text('Somthing went wrong !'),
                                );
                              } else if (snapshot.hasData) {
                                return const MailVerificationPage();
                              } else if (snapshot.hasData &&
                                  userViewModel.userData!.userStatus == false) {
                                authController.signOutUser();
                                return const AuthPage();
                              } else {
                                return const AuthPage();
                              }
                            },
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 5),
                    width: (screenSize.width / 2) - 15,
                    height: (screenSize.width / 2) - 15,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      // color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                        ),
                        Text(
                          'User',
                          style: TextStyle(
                            color: AppColors.blackColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
