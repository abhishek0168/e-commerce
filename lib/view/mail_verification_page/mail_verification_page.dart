import 'dart:async';

import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/main_page/main_page.dart';
import 'package:ecommerce_app/view/widgets/custom_submit_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MailVerificationPage extends StatefulWidget {
  const MailVerificationPage({super.key});

  @override
  State<MailVerificationPage> createState() => _MailVerificationPageState();
}

class _MailVerificationPageState extends State<MailVerificationPage> {
  bool isEmailVerified = false;
  bool canResentEmail = true;

  Timer? time;
  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();

      time = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  Future sendVerificationEmail() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
    setState(() {
      canResentEmail = false;
    });
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      canResentEmail = true;
    });
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) time?.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    time?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (isEmailVerified) {
      return MainPage();
    } else {
      final screenSize = MediaQuery.sizeOf(context);
      return Scaffold(
        appBar: AppBar(
          title: const Text('Verify Email'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('A verification email has been sent to your email'),
                height20,
                // ElevatedButton(
                //   onPressed: canResentEmail ? sendVerificationEmail : null,
                //   child: const Text('Resent Email'),
                // ),
                CustomSubmitButton(
                  screenSize: screenSize,
                  onPress: canResentEmail ? sendVerificationEmail : null,
                  title: 'Resent Email',
                ),
                height10,
                OutlinedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
