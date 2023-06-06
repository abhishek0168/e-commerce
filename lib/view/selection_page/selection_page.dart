import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/admin_panel/admin_page.dart';
import 'package:ecommerce_app/view/main_page/main_page.dart';
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
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(),
                    ),
                  );
                },
                child: const Text('User Page')),
            height10,
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminPage(),
                    ),
                  );
                },
                child: const Text('Admin Page')),
          ],
        ),
      )),
    );
  }
}
