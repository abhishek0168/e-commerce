import 'package:ecommerce_app/utils/constants.dart';

import 'package:ecommerce_app/view/admin_panel/product_page/admin_product_diplaying_page.dart';
import 'package:ecommerce_app/view/main_page/main_page.dart';
import 'package:ecommerce_app/view/sign_in_and_sign_up/Auth_page.dart';
import 'package:ecommerce_app/view/widgets/waiting_page.dart';
import 'package:ecommerce_app/view_model/product_data_from_firebase.dart';
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
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            height10,
            ElevatedButton(
                onPressed: () async {
                  await dataFromFirebase.callPrductDetails();
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminDisplayPage(),
                      ),
                    );
                  }
                },
                child: const Text('Admin Page')),
            height10,
            ElevatedButton(
              onPressed: () async {
                await dataFromFirebase.callPrductDetails();
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
                          } else if (snapshot.hasData &&
                              userViewModel.userData!.userStatus) {
                            return MainPage();
                          } else {
                            return const AuthPage();
                          }
                        },
                      ),
                    ),
                  );
                }
              },
              child: const Text('User Page'),
            ),
          ],
        ),
      )),
    );
  }
}
