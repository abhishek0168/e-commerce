import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  const CustomSubmitButton({
    super.key,
    required this.screenSize,
    required this.onPress,
    required this.title,
    this.bgColor,
  });

  final Size screenSize;
  final VoidCallback onPress;
  final String title;
  final Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPress,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          Size(screenSize.width, 50),
        ),
        backgroundColor:
            bgColor != null ? MaterialStatePropertyAll(bgColor) : null,
      ),
      child: Text(title.toUpperCase()),
    );
  }
}
