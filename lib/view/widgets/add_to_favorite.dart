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
    final userDetailsController =
        Provider.of<UserDetailsViewModel>(context, listen: true);
    return CircleAvatar(
      backgroundColor: AppColors.whiteColor,
      child: IconButton(
        onPressed: onPress,
        icon: userDetailsController.userFavs.contains(productId)
            ? const Icon(
                Icons.favorite,
                color: AppColors.primaryColor,
              )
            : const Icon(Icons.favorite_border),
      ),
    );
  }
}
