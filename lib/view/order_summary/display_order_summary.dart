import 'package:ecommerce_app/model/order_model/order_model.dart';
import 'package:ecommerce_app/model/user_model/user_model.dart';
import 'package:ecommerce_app/view/widgets/address_widget.dart';
import 'package:flutter/material.dart';

class DisplayOrderSummary extends StatelessWidget {
  const DisplayOrderSummary({super.key, required this.orderData});

  final OrderModel orderData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order summary'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
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
        ],
      ),
    );
  }
}
