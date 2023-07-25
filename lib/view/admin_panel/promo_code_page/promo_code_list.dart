import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/admin_panel/promo_code_page/promo_code_adding.dart';
import 'package:ecommerce_app/view/widgets/promo_code_widget.dart';
import 'package:ecommerce_app/view/widgets/three_dot_loading.dart';
import 'package:ecommerce_app/view_model/promo_code_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromoCodeList extends StatelessWidget {
  const PromoCodeList({super.key});

  @override
  Widget build(BuildContext context) {
    final productModel = context.watch<PromoCodeViewModel>();
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promocodes'),
      ),
      body: FutureBuilder(
        future: productModel.getPromoCodes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              var promoCodes = snapshot.data;
              return ListView.separated(
                itemBuilder: (context, index) => PromoCodeWidget(
                  screenSize: screenSize,
                  promoCode: promoCodes[index].promoCode,
                  expiryDate: promoCodes[index].expiryDate,
                  discount: promoCodes[index].discount,
                ),
                separatorBuilder: (context, index) => height20,
                itemCount: promoCodes!.length,
              );
            } else {
              return const Center(
                child: Text('No promo codes are available'),
              );
            }
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Somthing went wrong !'),
            );
          } else {
            return threeDotLoadingAnimation();
          }
        },
      ),
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
