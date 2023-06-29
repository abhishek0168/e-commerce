import 'dart:developer';

import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/heading_widget.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SizeBottomSheet extends StatelessWidget {
  const SizeBottomSheet({super.key, required this.productDetails});
  final ProductModel productDetails;
  @override
  Widget build(BuildContext context) {
    final userDetailsModel = Provider.of<UserDetailsViewModel>(context);
    List<String> keyList = productDetails.productSizes.keys.toList();
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 5,
              width: 100,
              decoration: BoxDecoration(
                  color: AppColors.grayColor,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const H2(text: 'Select Size'),
          Consumer<UserDetailsViewModel>(
            builder: (context, controller, child) {
              return Wrap(
                children: List.generate(
                  keyList.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChoiceChip(
                      label: Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 20,
                        child: Text(keyList[index]),
                      ),
                      selected: controller.sizeIsSelected == index,
                      onSelected:
                          productDetails.productSizes[keyList[index]] == 0
                              ? null
                              : (value) {
                                  log('chip value change');
                                  controller.changeSize(
                                      value, index, keyList[index]);
                                },
                    ),
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              onPressed: userDetailsModel.selectedSize == null
                  ? null
                  : () {
                      userDetailsModel.addToCart(
                          productId: productDetails.id,
                          color: productDetails.productColor,
                          size: userDetailsModel.selectedSize!,
                          count: 1);
                      Navigator.pop(context);
                    },
              style: const ButtonStyle(
                minimumSize: MaterialStatePropertyAll(
                  Size(double.infinity, 50),
                ),
              ),
              child: const Text('Continue'),
            ),
          ),
          height20,
        ],
      ),
    );
  }
}
