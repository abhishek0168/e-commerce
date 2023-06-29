import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/product_view/product_view_page.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/add_to_favorite.dart';
import 'package:ecommerce_app/view/widgets/page_empty_message.dart';
import 'package:ecommerce_app/view/widgets/product_card.dart';
import 'package:ecommerce_app/view_model/product_data_from_firebase.dart';
import 'package:ecommerce_app/view_model/shop_view_model.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatelessWidget {
  ShopPage({super.key});
  final List<String> filterChips = [
    'T-shirts',
    'Crop tops',
    'Midi Dress',
    'Salwar Kameez',
    'Lehenga Choli',
  ];

  @override
  Widget build(BuildContext context) {
    final shopViewModel = context.watch<ShopViewModel>();
    final firebaseDataController = Provider.of<DataFromFirebase>(context);

    final userDetailsController = Provider.of<UserDetailsViewModel>(context);
    return RefreshIndicator(
      onRefresh: () => firebaseDataController.callPrductDetails(),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filterChips
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                        showCheckmark: false,
                        label: Text(e),
                        labelStyle: TextStyle(
                            color: shopViewModel.filter.contains(e)
                                ? AppColors.whiteColor
                                : AppColors.blackColor),
                        selected: shopViewModel.filter.contains(e),
                        selectedColor: AppColors.blackColor,
                        onSelected: (value) {
                          shopViewModel.changeSelection(value, e);
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
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
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.swap_vert),
                  label: const Text('Sort'),
                ),
              ],
            ),
          ),
          height10,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Consumer<DataFromFirebase>(
                builder: (context, value, child) {
                  // List<ProductModel> productData = value.selectedProductsData;
                  return value.selectedProductsData.isNotEmpty
                      ? AnimationLimiter(
                          child: GridView.builder(
                            itemCount: value.selectedProductsData.length,
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
                                columnCount: value.selectedProductsData.length,
                                child: ScaleAnimation(
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductViewPage(
                                          productDetails:
                                              value.selectedProductsData[index],
                                        ),
                                      ),
                                    ),
                                    child: ProductCard(
                                      productModel:
                                          value.selectedProductsData[index],
                                      iconWidget: AddToFavoriteWidget(
                                          productId: value
                                              .selectedProductsData[index].id,
                                          onPress: () {
                                            userDetailsController.addtoFav(
                                                value
                                                    .selectedProductsData[index]
                                                    .id,
                                                context);
                                          }),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const PageEmptyMessage();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
