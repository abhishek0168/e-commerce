import 'package:ecommerce_app/view/widgets/page_empty_message.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetailsModel = Provider.of<UserDetailsViewModel>(context);
    return userDetailsModel.userFavs.isNotEmpty
        ? const Placeholder()
        : const PageEmptyMessage();
  }
}
