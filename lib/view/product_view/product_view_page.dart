import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/add_to_favorite.dart';
import 'package:ecommerce_app/view/widgets/heading_widget.dart';
import 'package:ecommerce_app/view/widgets/product_size_bottom_sheet.dart';
import 'package:ecommerce_app/view/widgets/text_styles.dart';
import 'package:ecommerce_app/view/widgets/three_dot_loading.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductViewPage extends StatelessWidget {
  const ProductViewPage({super.key, required this.productDetails});

  final ProductModel productDetails;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // final userDetailsViewModel = Provider.of<UserDetailsViewModel>(context);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(productDetails.brandName),
              snap: true,
              floating: true,
              toolbarHeight: 40,
              elevation: 10,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                ),
              ],
            ),
          ];
        },
        body: ListView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: productDetails.productImages
                    .map(
                      (image) => SizedBox(
                        height: (screenSize.height) - 250,
                        width: screenSize.width,
                        child: InteractiveViewer(
                          minScale: 1.0,
                          maxScale: 2.0,
                          child: Hero(
                            tag: image,
                            child: CachedNetworkImage(
                              imageUrl: image,
                              placeholder: (context, url) =>
                                  threeDotLoadingAnimation(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            height20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer<UserDetailsViewModel>(
                        builder: (context, value, child) => OutlinedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => SizeBottomSheet(
                                  productDetails: productDetails),
                            );
                          },
                          icon: const Icon(Icons.expand_more),
                          label: Text(
                            value.selectedSize ?? 'Size',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      Consumer<UserDetailsViewModel>(
                        builder: (context, value, child) => AddToFavoriteWidget(
                          productId: productDetails.id,
                          onPress: () {
                            value.addtoFav(productDetails.id, context);
                          },
                        ),
                      ),
                    ],
                  ),
                  height20,
                  // H2(text: productDetails.brandName),
                  Text(
                    productDetails.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    child: productDetails.productDiscount < 1
                        ? H2(text: '₹${productDetails.productPrice}')
                        : Row(
                            children: [
                              Text(
                                '₹${productDetails.productPrice}',
                                style: CustomeTextStyle.productName.copyWith(
                                    color: AppColors.grayColor,
                                    decoration: TextDecoration.lineThrough),
                              ),
                              width10,
                              Text(
                                '₹${productDetails.productDiscountedprice} ',
                                style: CustomeTextStyle.productName
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                              Text(
                                '(${productDetails.productDiscount}% off)',
                                style: const TextStyle(
                                    color: AppColors.primaryColor),
                              ),
                            ],
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
                  height20,
                  Consumer<UserDetailsViewModel>(
                    builder: (context, value, child) => FilledButton(
                      onPressed: () async {
                        if (value.selectedSize == null) {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) =>
                                SizeBottomSheet(productDetails: productDetails),
                          );
                        } else {
                          await value.addToCart(
                            productId: productDetails.id,
                            color: productDetails.productColor,
                            size: value.selectedSize!,
                            count: 1,
                          );
                        }
                      },
                      style: const ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(
                          Size(double.infinity, 50),
                        ),
                      ),
                      child: Text(
                        !value.userCart.any(
                          (element) => element['id'] == productDetails.id,
                        )
                            ? 'Add to Cart'
                            : 'Remove from Cart',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),

                  height20,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
