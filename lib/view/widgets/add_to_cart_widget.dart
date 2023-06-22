import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:flutter/material.dart';

class AddtoCartWidget extends StatelessWidget {
  const AddtoCartWidget({
    super.key,
    required this.onPress,
  });

  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    // final userDetailsController = Provider.of<UserDetailsViewModel>(context);
    return CircleAvatar(
      backgroundColor: AppColors.whiteColor,
      child: IconButton(
        tooltip: 'Add to cart',
        onPressed: onPress,
        icon: const Icon(Icons.local_grocery_store_outlined),
      ),
    );
  }
}
