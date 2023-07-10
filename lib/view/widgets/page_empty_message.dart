import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';

class PageEmptyMessage extends StatelessWidget {
  const PageEmptyMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/icons8-empty-cart.gif',
          ),
          height20,
          const Text('This page is empty !'),
        ],
      ),
    );
  }
}
