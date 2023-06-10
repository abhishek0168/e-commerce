import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:flutter/material.dart';

class AddToFavoriteWidget extends StatelessWidget {
  const AddToFavoriteWidget({
    super.key,
    required this.onPress,
  });
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.whiteColor,
      child: IconButton(
          onPressed: () {
            onPress;
          },
          icon: const Icon(Icons.favorite_border)),
    );
  }
}
