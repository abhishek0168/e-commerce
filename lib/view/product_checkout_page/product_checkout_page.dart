import 'package:ecommerce_app/model/user_model/user_model.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/user_address_adding_%20page/add_user_address.dart';
import 'package:ecommerce_app/view/user_address_adding_%20page/select_user_address.dart';
import 'package:ecommerce_app/view/widgets/address_widget.dart';
import 'package:ecommerce_app/view/widgets/heading_widget.dart';
import 'package:ecommerce_app/view_model/user_address_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCheckOutPage extends StatelessWidget {
  const ProductCheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Provider.of<AddressViewModel>(context);

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
            addressController.selectedAddress != null
                ? AddressShowWidget(
                    data: addressController.selectedAddress!,
                    navigateTo: const SelectUserAddress(),
                  )
                : TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SelectUserAddress(),
                      ));
                    },
                    child: const Text('Add address')),
            height20,
            height20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const H2(text: 'Payment'),
                TextButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                  child: const Text('Change'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
