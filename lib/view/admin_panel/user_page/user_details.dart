import 'package:ecommerce_app/model/order_model/order_model.dart';
import 'package:ecommerce_app/model/user_model/user_model.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/order_summary/display_order_summary.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/three_dot_loading.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final userDetailsModel = Provider.of<UserDetailsViewModel>(context);
    UserModel userData = userDetailsModel.usersList
        .where((element) => element.id == userId)
        .single;
    final orderDetails = userData.userOrders!
        .map((e) => OrderModel(
              discount: e['discount'],
              delivery: e['delivery'],
              date: e['date'],
              id: e['id'],
              amount: e['amount'],
              address: e['address'],
              cartDetails: e['cartDetails'],
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              // SvgPicture.asset(
              //   'assets/svgs/user-image-with-black-background-svgrepo-com.svg',
              //   width: 190,
              // ),
              DataTable(
                columns: const [
                  DataColumn(
                      label: Text(
                    'User',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataColumn(
                      label: Text(
                    'Details',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ],
                rows: [
                  DataRow(
                    cells: [
                      const DataCell(Text('Id')),
                      DataCell(Text(userData.id)),
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(Text('Name')),
                      DataCell(Text(userData.userName)),
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(Text('Email')),
                      DataCell(Text(userData.userEmail)),
                    ],
                  ),
                  /* DataRow(
                    cells: [
                      const DataCell(Text('Block')),
                      DataCell(
                        FilledButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Block user'),
                                content: userData.userStatus
                                    ? const Text(
                                        'Are sure you want to block this user ?')
                                    : const Text(
                                        'Are sure you want to unblock this user ?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      userDetailsModel.userStatus(
                                          userData.id, userData.userStatus);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                                surfaceTintColor: AppColors.whiteColor,
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                userData.userStatus
                                    ? AppColors.primaryColor
                                    : AppColors.sumbitColor),
                          ),
                          child: userData.userStatus
                              ? const Text('Block')
                              : const Text('Unblock'),
                        ),
                      ),
                    ],
                  ), */
                ],
              ),
              height20,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Orders',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              height10,
              if (orderDetails.isNotEmpty)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                                  'Tracking no. : ${orderDetails[index].id}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(orderDetails[index].date),
                            ],
                          ),
                          height10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Items : ${orderDetails[index].cartDetails.length}'),
                              Text(
                                  'Total amount : ₹${orderDetails[index].amount}'),
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
                                        orderData: orderDetails[index],
                                      ),
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
                  separatorBuilder: (context, index) {
                    return height10;
                  },
                  itemCount: orderDetails.length,
                )
              else
                const Center(child: Text('No orders available')),
            ],
          ),
          Consumer<UserDetailsViewModel>(
            builder: (context, value, child) => Visibility(
              visible: value.isLoading,
              child: Container(
                color: AppColors.whiteColor.withOpacity(0.5),
                width: double.infinity,
                height: double.infinity,
                child: threeDotLoadingAnimation(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
