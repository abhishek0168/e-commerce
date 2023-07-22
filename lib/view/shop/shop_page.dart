import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/product_view/product_view_page.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/add_to_favorite.dart';
import 'package:ecommerce_app/view/widgets/page_empty_message.dart';
import 'package:ecommerce_app/view/widgets/product_card.dart';
import 'package:ecommerce_app/view/widgets/three_dot_loading.dart';
import 'package:ecommerce_app/view_model/product_data_from_firebase.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final shopViewModel = context.watch<ShopViewModel>();
    final firebaseDataController = Provider.of<DataFromFirebase>(context);
    final userDetailsController = Provider.of<UserDetailsViewModel>(context);
    return RefreshIndicator(
      onRefresh: () => firebaseDataController.callPrductDetails(),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 0.1,
                  blurRadius: 7,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list),
                  label: const Text('Filter'),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    firebaseDataController.sortOnPress(value);
                  },
                  initialValue: SortProductBy.name,
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: SortProductBy.name,
                      child: Text('Name'),
                    ),
                    PopupMenuItem(
                      value: SortProductBy.price,
                      child: Text('Price'),
                    ),
                    PopupMenuItem(
                      value: SortProductBy.discount,
                      child: Text('Discount'),
                    ),
                  ],
                  child: const Row(
                    children: [
                      Icon(
                        Icons.swap_vert,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Sort',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          height10,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FutureBuilder(
                future: firebaseDataController.sortProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      final selectedProductsData = snapshot.data;
                      return AnimationLimiter(
                        child: GridView.builder(
                          itemCount: selectedProductsData!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 15,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            if (selectedProductsData[index].productStock != 0) {
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                columnCount: selectedProductsData.length,
                                child: ScaleAnimation(
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductViewPage(
                                          productDetails:
                                              selectedProductsData[index],
                                        ),
                                      ),
                                    ),
                                    child: ProductCard(
                                      productModel: selectedProductsData[index],
                                      iconWidget: AddToFavoriteWidget(
                                          productId:
                                              selectedProductsData[index].id,
                                          onPress: () {
                                            userDetailsController.addtoFav(
                                                selectedProductsData[index].id,
                                                context);
                                          }),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return null;
                            }
                          },
                        ),
                      );
                    } else {
                      return const PageEmptyMessage();
                    }
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Somthing went wrong'),
                    );
                  } else {
                    return threeDotLoadingAnimation();
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
