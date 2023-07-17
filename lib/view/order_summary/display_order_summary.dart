import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/model/order_model/order_model.dart';
import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/model/user_model/user_model.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/widgets/address_widget.dart';
import 'package:ecommerce_app/view/widgets/heading_widget.dart';
import 'package:ecommerce_app/view/widgets/three_dot_loading.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayOrderSummary extends StatelessWidget {
  const DisplayOrderSummary({super.key, required this.orderData});

  final OrderModel orderData;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final usreDetailModel = Provider.of<UserDetailsViewModel>(context);
    List<ProductModel> productsData =
        usreDetailModel.sortProducts(orderData.cartDetails);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order summary'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          Text(
            'Order ID : ${orderData.id}',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          height10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Items : ${orderData.cartDetails.length}'),
              Text(orderData.date),
            ],
          ),
          height20,
          height10,
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var productData = productsData
                  .where((element) =>
                      element.id == orderData.cartDetails[index]['id'])
                  .single;
              return ProductDetailsWidget(
                screenSize: screenSize,
                productDetails: orderData.cartDetails[index],
                productData: productData,
              );
            },
            separatorBuilder: (context, index) => height10,
            itemCount: orderData.cartDetails.length,
          ),
          height20,
          const H2(text: 'Order information'),
          height10,
          AddressShowWidget(
            data: UserAddress(
              id: orderData.address['id'],
              name: orderData.address['name'],
              mobileNumber: orderData.address['mobileNumber'],
              city: orderData.address['city'],
              houseName: orderData.address['houseName'],
              state: orderData.address['id'],
              district: orderData.address['state'],
              country: orderData.address['country'],
              pincode: orderData.address['pincode'],
              status: orderData.address['status'],
            ),
          ),
          height10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Discount :'),
              Text('₹${double.parse(orderData.discount).toStringAsFixed(2)}'),
            ],
          ),
          if (int.parse(orderData.amount) < 2000)
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery charge :'),
                Text('₹50'),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total amount :'),
              Text('₹${orderData.amount}'),
            ],
          ),
          height20,
          height20,
        ],
      ),
    );
  }
}

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({
    super.key,
    required this.screenSize,
    required this.productDetails,
    required this.productData,
  });

  final Size screenSize;
  final Map<dynamic, dynamic> productDetails;
  final ProductModel productData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: productData.productImages[0],
              placeholder: (context, url) => threeDotLoadingAnimation(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          height: 100,
          width: screenSize.width - 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                productData.productName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text('Color : ${productDetails['color']}'),
                  width20,
                  Text('Size : ${productDetails['size']}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('Units : ${productDetails['count']}'),
                  Text('₹${productData.productDiscountedprice}'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
