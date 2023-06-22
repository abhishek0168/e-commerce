import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/view/product_view/product_view_page.dart';
import 'package:ecommerce_app/view/widgets/add_to_cart_widget.dart';
import 'package:ecommerce_app/view/widgets/page_empty_message.dart';
import 'package:ecommerce_app/view/widgets/product_card.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetailsModel = Provider.of<UserDetailsViewModel>(context);
    // final screenSize = MediaQuery.of(context).size;
    return userDetailsModel.favProductData.isNotEmpty
        ? Column(children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AnimationLimiter(
                  child: Consumer<UserDetailsViewModel>(
                    builder: (context, value, child) {
                      List<ProductModel> productData = value.favProductData;
                      return GridView.builder(
                        itemCount: productData.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 15,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            columnCount: productData.length,
                            child: ScaleAnimation(
                              child: InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductViewPage(
                                      productDetails: productData[index],
                                    ),
                                  ),
                                ),
                                child: ProductCard(
                                  productModel: productData[index],
                                  closeWidget: IconButton(
                                    onPressed: () {
                                      userDetailsModel.addtoFav(
                                          productData[index].id, context);
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                                  iconWidget: AddtoCartWidget(
                                    onPress: () {
                                      userDetailsModel
                                          .addToCart(productData[index].id);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ])
        : const PageEmptyMessage();
  }
}
