import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/cart/product_cart_widget.dart';
import 'package:ecommerce_app/view/widgets/page_empty_message.dart';
import 'package:ecommerce_app/view/widgets/text_styles.dart';

import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    final userDetailsController = Provider.of<UserDetailsViewModel>(context);
    final screenSize = MediaQuery.of(context).size;
    // userDetailsController.fetchingUserData();
    return userDetailsController.userCart.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Total : ₹${userDetailsController.totalProductPrice}',
                        style: CustomeTextStyle.productName,
                      )
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Consumer<UserDetailsViewModel>(
                      builder: (context, value, child) {
                        return ListView.separated(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ProductCartWidget(
                                  productData: value.cartProductData[index],
                                  screenSize: screenSize);
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: value.cartProductData.length);
                      },
                    ),
                  ),
                ),
                height10,
              ],
            ),
          )
        : const PageEmptyMessage();
  }
}
