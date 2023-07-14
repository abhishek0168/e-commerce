import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/three_dot_loading.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCartWidget extends StatelessWidget {
  const ProductCartWidget({
    super.key,
    required this.productData,
    required this.screenSize,
  });

  final ProductModel productData;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    final userDetailsController = Provider.of<UserDetailsViewModel>(context);
    Map<dynamic, dynamic> prodcutDetails = userDetailsController.userCart
        .where((element) => element['id'] == productData.id)
        .single;
    ValueNotifier<int> counter = ValueNotifier(prodcutDetails['count']);
    return Dismissible(
      key: Key(productData.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => userDetailsController.addToCart(
          productId: productData.id,
          color: productData.productColor,
          size: '',
          count: 1,
          context: context),
      background: Container(
        padding: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.centerRight,
        child: const Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.delete,
            color: AppColors.whiteColor,
            size: 30,
          ),
        ),
      ),
      child: Row(
        children: [
          Flexible(
            child: SizedBox(
              width: (screenSize.width) / 3,
              height: 120,
              child: CachedNetworkImage(
                placeholder: (context, url) => threeDotLoadingAnimation(),
                imageUrl: productData.productImages[0],
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          width10,
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  productData.brandName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Size : ',
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: prodcutDetails['size'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    width20,
                    RichText(
                      text: TextSpan(
                        text: 'Color : ',
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: prodcutDetails['color'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                height20,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          IconButton.outlined(
                            onPressed: () {
                              if (counter.value > 1) {
                                counter.value--;
                                userDetailsController.updateCartCount(
                                  count: counter.value,
                                  prodcutDetails: prodcutDetails,
                                  context: context,
                                );
                              }
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          ValueListenableBuilder(
                            valueListenable: counter,
                            builder: (context, value, child) => Container(
                              width: 20,
                              height: 20,
                              alignment: Alignment.center,
                              child: Text('$value'),
                            ),
                          ),
                          IconButton.outlined(
                            onPressed: () {
                              int sizeCount = productData
                                  .productSizes[prodcutDetails['size']];
                              if (counter.value < sizeCount) {
                                counter.value++;
                                userDetailsController.updateCartCount(
                                    context: context,
                                    count: counter.value,
                                    prodcutDetails: prodcutDetails);
                              }
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '₹${productData.productDiscountedprice}',
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
          ),
          width20,
        ],
      ),
    );
  }
}
