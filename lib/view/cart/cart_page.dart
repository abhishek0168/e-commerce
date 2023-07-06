import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/cart/product_cart_widget.dart';
import 'package:ecommerce_app/view/cart/promo_code_field.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/custome_snackbar.dart';
import 'package:ecommerce_app/view/widgets/page_empty_message.dart';
import 'package:ecommerce_app/view/widgets/promo_code_widget.dart';
import 'package:ecommerce_app/view/widgets/text_styles.dart';
import 'package:ecommerce_app/view_model/promo_code_viewmodel.dart';

import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    final userDetailsController = Provider.of<UserDetailsViewModel>(context);
    final promoCodeController = Provider.of<PromoCodeViewModel>(context);
    final screenSize = MediaQuery.sizeOf(context);
    // userDetailsController.fetchingUserData();
    if (userDetailsController.userCart.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Consumer<UserDetailsViewModel>(
                builder: (context, value, child) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ProductCartWidget(
                          productData: value.cartProductData[index],
                          screenSize: screenSize);
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: value.cartProductData.length,
                  );
                },
              ),
            ),
            height10,
            TextFormField(
              controller: promoCodeController.promoCodeKeyController,
              maxLines: 1,
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Container(
                      height: (70 / 100) * screenSize.height,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              height: 5,
                              width: 100,
                              decoration: BoxDecoration(
                                color: AppColors.grayColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          PromoCodeField(
                            controller:
                                promoCodeController.promoCodeKeyController,
                          ),
                          height20,
                          // height20,
                          promoCodeController.promoCodes.isNotEmpty
                              ? Consumer<PromoCodeViewModel>(
                                  builder: (context, value, child) => Expanded(
                                    child: ListView.separated(
                                      itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          value.promoCodeToTextField(value
                                              .promoCodes[index].promoCode);
                                          Navigator.pop(context);
                                        },
                                        child: PromoCodeWidget(
                                          screenSize: screenSize,
                                          promoCode:
                                              value.promoCodes[index].promoCode,
                                          expiryDate: value
                                              .promoCodes[index].expiryDate,
                                          discount:
                                              value.promoCodes[index].discount,
                                        ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          height20,
                                      itemCount: value.promoCodes.length,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/empty-box.gif',
                                          width: 200,
                                        ),
                                        const Text(
                                            'Promo codes are not available'),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    );
                  },
                );
              },
              decoration: InputDecoration(
                hintText: 'Enter your promo code',
                hintStyle: TextStyle(color: AppColors.grayColor),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                suffixIcon: IconButton.filled(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(AppColors.blackColor)),
                  onPressed: () {
                    String message = promoCodeController.checkPromoCode(
                        promoCodeController.promoCodeKeyController.text.trim(),
                        userDetailsController.userData!.id);
                    final snackBar = CustomeSnackBar().snackBar1(
                        bgColor: AppColors.starColor, content: message);

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: AppColors.whiteColor,
                  ),
                  iconSize: 30,
                ),
              ),
            ),
            height20,
            FilledButton(
              onPressed: () {},
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  Size(screenSize.width, 50),
                ),
              ),
              child: const Text('Buy Now'),
            ),
            height10,
            const Divider(),
            height10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total amount : ',
                  style: CustomeTextStyle.productName
                      .copyWith(color: AppColors.grayColor),
                ),
                Text(
                  '₹${userDetailsController.totalProductPrice}',
                  style: CustomeTextStyle.productName,
                )
              ],
            ),
          ],
        ),
      );
    } else {
      return const PageEmptyMessage();
    }
  }
}
