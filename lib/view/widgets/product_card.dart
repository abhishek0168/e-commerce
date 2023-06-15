import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/add_to_favorite.dart';
import 'package:ecommerce_app/view/widgets/heading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/view/widgets/text_styles.dart';
import 'package:ecommerce_app/view/widgets/three_dot_loading.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.brandName,
    required this.productName,
    required this.productPrice,
    required this.productDiscount,
    required this.productDiscountPrice,
  });
  final String imageUrl;
  final String brandName;
  final String productName;
  final int productPrice;
  final int productDiscount;
  final int productDiscountPrice;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 200,
                    height: 240,
                    decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) => threeDotLoadingAnimation(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        color: AppColors.starColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                H2(text: brandName),
                SizedBox(
                  height: 35,
                  child: Text(
                    productName,
                    style: TextStyle(
                      color: AppColors.grayColor,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  child: productDiscount == 0
                      ? Row(
                          children: [
                            H2(text: '₹ $productPrice'),
                          ],
                        )
                      : Row(
                          children: [
                            Text(
                              '₹ $productPrice',
                              style: CustomeTextStyle.productName.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: AppColors.grayColor,
                              ),
                            ),
                            width10,
                            Text(
                              '₹$productDiscountPrice',
                              style: CustomeTextStyle.productName.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
          Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: productDiscount < 1 ? false : true,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 05, horizontal: 10),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      '$productDiscount%',
                      style: const TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                ),
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(
              //     Icons.clear,
              //     size: 25,
              //   ),
              // )
            ],
          ),
          Positioned(
            top: 120,
            right: 0,
            bottom: 0,
            child: AddToFavoriteWidget(
              onPress: () {},
            ),
          )
        ],
      ),
    );
  }
}
