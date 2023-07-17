import 'package:ecommerce_app/model/order_model/order_model.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/order_summary/display_order_summary.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:flutter/material.dart';

class DisplayOrderList extends StatelessWidget {
  const DisplayOrderList({
    super.key,
    required this.orderList,
  });
  final List<OrderModel> orderList;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Orders'),
      ),
      body: orderList.isNotEmpty
          ? ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: (50 / 100) * screenSize.width,
                            child: Text(
                              'Tracking no. : ${orderList[index].id}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(orderList[index].date),
                        ],
                      ),
                      height10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Items : ${orderList[index].cartDetails.length}'),
                          Text('Total amount : ₹${orderList[index].amount}'),
                        ],
                      ),
                      height10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DisplayOrderSummary(
                                      orderData: orderList[index]),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll(
                                  AppColors.sumbitColor),
                            ),
                            child: const Text('Details'),
                          ),
                          Text(
                            'Delivered',
                            style: TextStyle(color: AppColors.sumbitColor),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => height10,
              itemCount: orderList.length,
            )
          : const Center(
              child: Text('No Order available'),
            ),
    );
  }
}
