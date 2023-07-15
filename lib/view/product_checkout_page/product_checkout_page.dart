import 'dart:developer';

import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/order_summary/display_order_summary.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/user_address_adding_%20page/select_user_address.dart';
import 'package:ecommerce_app/view/widgets/address_widget.dart';
import 'package:ecommerce_app/view/widgets/custom_submit_button.dart';
import 'package:ecommerce_app/view/widgets/custome_snackbar.dart';
import 'package:ecommerce_app/view/widgets/heading_widget.dart';
import 'package:ecommerce_app/view_model/payment_view_model.dart';
import 'package:ecommerce_app/view_model/user_address_viewmodel.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCheckOutPage extends StatelessWidget {
  const ProductCheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Provider.of<AddressViewModel>(context);
    final paymentController = Provider.of<PaymentViewModel>(context);
    final userDetailsModel = Provider.of<UserDetailsViewModel>(context);
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Check out'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const H2(text: 'Shipping address'),
              height10,
              if (addressController.selectedAddress != null)
                AddressShowWidget(
                  data: addressController.selectedAddress!,
                  navigateTo: const SelectUserAddress(),
                )
              else
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SelectUserAddress(),
                      ));
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add address'),
                  ),
                ),
              height20,
              height20,
              const H2(text: 'Payment'),
              height20,
              Consumer<PaymentViewModel>(
                builder: (context, value, child) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: RadioListTile(
                    value: PaymentMethod.cod,
                    groupValue: value.selectedMethod,
                    onChanged: (option) {
                      value.changePaymentMethod(option!);
                    },
                    title: const Text('Cash on delivery'),
                  ),
                ),
              ),
              height10,
              Consumer<PaymentViewModel>(
                builder: (context, value, child) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: RadioListTile(
                    value: PaymentMethod.card,
                    groupValue: value.selectedMethod,
                    onChanged: (option) {
                      value.changePaymentMethod(option!);
                    },
                    title: const Text('Credit / Debit card'),
                  ),
                ),
              ),
              height10,
              Consumer<PaymentViewModel>(
                builder: (context, value, child) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: RadioListTile(
                    value: PaymentMethod.upi,
                    groupValue: value.selectedMethod,
                    onChanged: (option) {
                      value.changePaymentMethod(option!);
                    },
                    title: const Text('UPI'),
                  ),
                ),
              ),
              height10,
              height20,
              CustomSubmitButton(
                screenSize: screenSize,
                bgColor: AppColors.sumbitColor,
                onPress: () async {
                  if (addressController.selectedAddress == null) {
                    var snackBar = CustomeSnackBar().snackBar1(
                      bgColor: AppColors.primaryColor,
                      content: 'Add shipping address',
                      textColor: AppColors.whiteColor,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (paymentController.selectedMethod ==
                      PaymentMethod.card) {
                    await paymentController.makePayment(
                      context,
                      '1300',
                      addressController.selectedAddress!,
                    );
                  } else if (paymentController.selectedMethod ==
                      PaymentMethod.cod) {
                    log('cash on delivery selected');
                    await userDetailsModel
                        .clearUserCart(addressController.selectedAddress!);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => DisplayOrderSummary(
                          orderData: userDetailsModel.totalOrderList.last),
                    ));
                  } else if (paymentController.selectedMethod ==
                      PaymentMethod.upi) {
                    log('UPI selected');
                  }
                },
                title: 'make payment',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
