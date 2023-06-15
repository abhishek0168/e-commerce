import 'package:ecommerce_app/utils/constants.dart';

import 'package:ecommerce_app/view/admin_panel/admin_product_diplaying_page.dart';
import 'package:ecommerce_app/view/main_page/main_page.dart';
import 'package:ecommerce_app/view/sign_in_and_sign_up/login_page.dart';
import 'package:ecommerce_app/view/widgets/three_dot_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            height10,
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminDisplayPage(),
                    ),
                  );
                },
                child: const Text('Admin Page')),
            height10,
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StreamBuilder<User?>(
                        stream: FirebaseAuth.instance.authStateChanges(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return threeDotLoadingAnimation();
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
                            return MainPage();
                          } else {
                            return LoginInPage();
                          }
                        }),
                  ),
                );
              },
              child: const Text('User Page'),
            ),
          ],
        ),
      )),
    );
  }
}
