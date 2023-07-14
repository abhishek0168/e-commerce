import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/user_address_adding_%20page/select_user_address.dart';
import 'package:ecommerce_app/view/widgets/address_widget.dart';
import 'package:ecommerce_app/view/widgets/custome_snackbar.dart';
import 'package:ecommerce_app/view/widgets/heading_widget.dart';
import 'package:ecommerce_app/view_model/payment_view_model.dart';
import 'package:ecommerce_app/view_model/user_address_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCheckOutPage extends StatelessWidget {
  const ProductCheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Provider.of<AddressViewModel>(context);
    final paymentController = Provider.of<PaymentViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Check out'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
            ElevatedButton(
              onPressed: () {
                if (addressController.selectedAddress != null) {
                  paymentController.makePayment(context, '1300');
                } else {
                  var snackBar = CustomeSnackBar().snackBar1(
                    bgColor: AppColors.primaryColor,
                    content: 'Add shipping address',
                    textColor: AppColors.whiteColor,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text('Make payment'),
            ),
            Container(
              decoration: const BoxDecoration(),
              alignment: Alignment.center,
              child: RadioListTile(
                value: null,
                groupValue: null,
                onChanged: (bahu) {},
                title: const Text('Cash on delivery'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
