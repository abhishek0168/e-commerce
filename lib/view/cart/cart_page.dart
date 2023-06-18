import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/cart/product_cart_widget.dart';
import 'package:ecommerce_app/view/widgets/page_empty_message.dart';
import 'package:ecommerce_app/view/widgets/text_styles.dart';
import 'package:ecommerce_app/view_model/product_data_from_firebase.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  final int columnCount = 10;
  @override
  Widget build(BuildContext context) {
    final userDetailsController = Provider.of<UserDetailsViewModel>(context);
    final productDetails = Provider.of<DataFromFirebase>(context);
    final screenSize = MediaQuery.of(context).size;
    List<ProductModel> productData =
        userDetailsController.getCartProducts(productDetails.productsData);
    return Scaffold(
      body: userDetailsController.userCart.isNotEmpty
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                                  productData: productData[index],
                                  screenSize: screenSize);
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: productData.length);
                      },
                    ),
                  ),
                ),
                height10,
                const Divider(),
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
              ],
            )
          : const PageEmptyMessage(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: userDetailsController.userCart.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FilledButton(
                onPressed: () {},
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    Size(screenSize.width, 50),
                  ),
                ),
                child: const Text('Buy Now'),
              ),
            )
          : null,
    );
  }
}
