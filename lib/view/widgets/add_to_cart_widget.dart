import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToFavoriteWidget extends StatelessWidget {
  const AddToFavoriteWidget({
    super.key,
    required this.productId,
    required this.onPress,
  });
  final String productId;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    final userDetailsController = Provider.of<UserDetailsViewModel>(context);
    return CircleAvatar(
      backgroundColor: AppColors.whiteColor,
      child: IconButton(
        tooltip: 'Add to cart',
        onPressed: onPress,
        icon: userDetailsController.userCart.contains(productId)
            ? Icon(
                Icons.local_grocery_store,
                color: AppColors.grayColor,
              )
            : const Icon(Icons.local_grocery_store_outlined),
      ),
    );
  }
}
