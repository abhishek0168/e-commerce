import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/add_to_favorite.dart';
import 'package:ecommerce_app/view/widgets/heading_widget.dart';
import 'package:ecommerce_app/view/widgets/text_styles.dart';
import 'package:flutter/material.dart';

class ProductViewPage extends StatelessWidget {
  const ProductViewPage(
      {super.key, required this.productData, this.productDiscountPrice});

  final ProductModel productData;
  final int? productDiscountPrice;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(productData.brandName),
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
        body: SafeArea(
          child: ListView(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: productData.productImages
                      .map(
                        (image) => SizedBox(
                          height: (screenSize.height) - 250,
                          width: screenSize.width,
                          child: CachedNetworkImage(
                            placeholder: (context, url) => const Center(
                                child: Padding(
                              padding: EdgeInsets.all(12),
                              child: LinearProgressIndicator(),
                            )),
                            imageUrl: image,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
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
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.expand_more),
                          label: const Text(
                            'Size',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        AddToFavoriteWidget(
                          onPress: () {},
                        ),
                      ],
                    ),
                    height20,
                    // H2(text: productData.brandName),
                    Text(
                      productData.productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      child: productData.productDiscount < 1
                          ? H2(text: '₹${productData.productPrice}')
                          : Row(
                              children: [
                                Text(
                                  '₹${productData.productPrice}',
                                  style: CustomeTextStyle.productName.copyWith(
                                      color: AppColors.grayColor,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                width10,
                                Text(
                                  '₹$productDiscountPrice ',
                                  style: CustomeTextStyle.productName
                                      .copyWith(color: AppColors.primaryColor),
                                ),
                                Text(
                                  '(${productData.productDiscount}% off)',
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
                    FilledButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(
                          Size(double.infinity, 50),
                        ),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 18,
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
      ),
    );
  }
}
