import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:flutter/material.dart';

class AdminProductViewPage extends StatelessWidget {
  const AdminProductViewPage({super.key, required this.productData});

  final ProductModel productData;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.update))],
      ),
      body: ListView(children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productData.productImages
                .map(
                  (image) => SizedBox(
                    width: screenSize.width / 2,
                    height: 350,
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: Image.asset(
                          'assets/images/rive_loading.gif',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        height10,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productData.productName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              height10,
              Text(
                '₹${productData.productPrice}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor),
              ),
              height10,
              Text(productData.productColor),
              Text(productData.productCategory),
              Text('${productData.productDiscount}'),
              Text(productData.brandName)
            ],
          ),
        )
      ]),
    );
  }
}
