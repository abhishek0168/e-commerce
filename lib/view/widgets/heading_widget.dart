import 'package:ecommerce_app/view/widgets/text_styles.dart';
import 'package:flutter/material.dart';

class H2 extends StatelessWidget {
  const H2({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: CustomeTextStyle.productName,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
