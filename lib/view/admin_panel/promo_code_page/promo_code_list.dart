import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/admin_panel/promo_code_page/promo_code_adding.dart';
import 'package:ecommerce_app/view/widgets/promo_code_widget.dart';
import 'package:ecommerce_app/view_model/promo_code_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromoCodeList extends StatelessWidget {
  const PromoCodeList({super.key});

  @override
  Widget build(BuildContext context) {
    final promoCodeModel = Provider.of<PromoCodeViewModel>(context);
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promocodes'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => PromoCodeWidget(
                screenSize: screenSize,
                promoCode: promoCodeModel.promoCodes[index].promoCode,
                expiryDate: promoCodeModel.promoCodes[index].expiryDate,
                discount: promoCodeModel.promoCodes[index].discount,
              ),
          separatorBuilder: (context, index) => height20,
          itemCount: promoCodeModel.promoCodes.length),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PromoCodeAddingPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
