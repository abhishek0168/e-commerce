import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  const CustomSubmitButton({
    super.key,
    required this.screenSize,
    required this.onPress,
    required this.title,
  });

  final Size screenSize;
  final VoidCallback onPress;
  final String title;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPress,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          Size(screenSize.width, 50),
        ),
      ),
      child: Text(title.toUpperCase()),
    );
  }
}