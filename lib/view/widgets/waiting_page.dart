import 'package:ecommerce_app/view/widgets/three_dot_loading.dart';
import 'package:flutter/material.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: threeDotLoadingAnimation(),
    );
  }
}
