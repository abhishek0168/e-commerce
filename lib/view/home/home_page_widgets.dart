import 'package:ecommerce_app/view/widgets/text_styles.dart';
import 'package:flutter/material.dart';

enum TextPosition {
  bottom,
  center,
}

class ImageDispaly extends StatelessWidget {
  const ImageDispaly(
      {super.key,
      required this.imgaeDr,
      required this.text,
      this.alignment,
      this.position});
  final String imgaeDr;
  final String text;
  final AlignmentGeometry? alignment;
  final TextPosition? position;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: position == TextPosition.bottom
          ? AlignmentDirectional.bottomCenter
          : AlignmentDirectional.center,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                imgaeDr,
              ),
              fit: BoxFit.cover,
              alignment: alignment ?? Alignment.center,
            ),
          ),
        ),
        Positioned(
          child: Text(text, style: CustomeTextStyle.mainHeadingWhite),
        ),
      ],
    );
  }
}
