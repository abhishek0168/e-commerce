import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/admin_panel/admin_product_adding_page.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view_model/admin_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminProductViewPage extends StatelessWidget {
  const AdminProductViewPage({super.key, required this.productData});

  final ProductModel productData;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final controller = Provider.of<AdminPageViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              controller.assignValues(productData);
              controller.isUpdate = true;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminProductAddingPage(
                    productId: productData.id,
                  ),
                ),
              );
            },
            child: const Text('Edit'),
          ),
        ],
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
              RichText(
                text: TextSpan(
                  text: 'Color : ',
                  style: const TextStyle(
                      color: AppColors.blackColor, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                      text: productData.productColor,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Category : ',
                  style: const TextStyle(
                      color: AppColors.blackColor, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                      text: productData.productCategory,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Discount : ',
                  style: const TextStyle(
                      color: AppColors.blackColor, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${productData.productDiscount}%',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Status : ',
                  style: const TextStyle(
                      color: AppColors.blackColor, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                      text: productData.status ? 'available' : 'unavailable',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
