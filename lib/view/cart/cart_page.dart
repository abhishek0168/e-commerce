import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/cart/product_cart_widget.dart';
import 'package:ecommerce_app/view/cart/promo_code_field.dart';
import 'package:ecommerce_app/view/product_checkout_page/product_checkout_page.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/custom_submit_button.dart';
import 'package:ecommerce_app/view/widgets/custome_snackbar.dart';
import 'package:ecommerce_app/view/widgets/page_empty_message.dart';
import 'package:ecommerce_app/view/widgets/promo_code_widget.dart';
import 'package:ecommerce_app/view/widgets/text_styles.dart';
import 'package:ecommerce_app/view_model/promo_code_viewmodel.dart';

import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    final userDetailsController = Provider.of<UserDetailsViewModel>(context);
    final promoCodeController = Provider.of<PromoCodeViewModel>(context);
    final screenSize = MediaQuery.sizeOf(context);

    userDetailsController.cartScrollContoller.addListener(() {
      if (userDetailsController
              .cartScrollContoller.position.userScrollDirection ==
          ScrollDirection.reverse) {
        userDetailsController.cartScrollDown();
      } else {
        userDetailsController.cartScrollUp();
      }
    });

    // userDetailsController.fetchingUserData();
    if (userDetailsController.userCart.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Consumer<UserDetailsViewModel>(
                builder: (context, value, child) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      value.cartScrollUp();
                    },
                    child: ListView.separated(
                      dragStartBehavior: DragStartBehavior.down,
                      controller: userDetailsController.cartScrollContoller,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ProductCartWidget(
                            productData: value.cartProductData[index],
                            screenSize: screenSize);
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: value.cartProductData.length,
                    ),
                  );
                },
              ),
            ),
            Consumer<UserDetailsViewModel>(
              builder: (context, value, child) => Visibility(
                visible: value.cartIsScrolling,
                // maintainAnimation: true,
                child: Column(
                  children: [
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
                                    controller: promoCodeController
                                        .promoCodeKeyController,
                                  ),
                                  height20,
                                  // height20,
                                  promoCodeController.promoCodes.isNotEmpty
                                      ? Consumer<PromoCodeViewModel>(
                                          builder: (context, value, child) =>
                                              Expanded(
                                            child: ListView.separated(
                                              itemBuilder: (context, index) =>
                                                  InkWell(
                                                onTap: () {
                                                  value.promoCodeToTextField(
                                                      value.promoCodes[index]
                                                          .promoCode);
                                                  Navigator.pop(context);
                                                },
                                                child: PromoCodeWidget(
                                                  screenSize: screenSize,
                                                  promoCode: value
                                                      .promoCodes[index]
                                                      .promoCode,
                                                  expiryDate: value
                                                      .promoCodes[index]
                                                      .expiryDate,
                                                  discount: value
                                                      .promoCodes[index]
                                                      .discount,
                                                ),
                                              ),
                                              separatorBuilder:
                                                  (context, index) => height20,
                                              itemCount:
                                                  value.promoCodes.length,
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
                              backgroundColor: MaterialStatePropertyAll(
                                  AppColors.blackColor)),
                          onPressed: () {
                            String message = '';
                            if (userDetailsController.isPromoCodeUsed) {
                              promoCodeController.promoCodeKeyController
                                  .clear();
                              userDetailsController.removePromoCode();
                              message = 'Promo code removed';
                            } else {
                              message = userDetailsController.checkPromoCode(
                                  promoCodeController
                                      .promoCodeKeyController.text
                                      .trim(),
                                  userDetailsController.userData!.id,
                                  promoCodeController.promoCodes);
                            }
                            final snackBar = CustomeSnackBar().snackBar1(
                                bgColor: AppColors.starColor, content: message);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          icon: userDetailsController.isPromoCodeUsed
                              ? const Icon(
                                  Icons.clear,
                                  color: AppColors.whiteColor,
                                )
                              : const Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.whiteColor,
                                ),
                          iconSize: 30,
                        ),
                      ),
                    ),
                    height20,
                    CustomSubmitButton(
                      screenSize: screenSize,
                      onPress: () {
                        Navigator.of(context).push(_createRoute());
                      },
                      title: 'check out',
                    ),
                    height10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total amount : ',
                          style: TextStyle(
                            color: AppColors.grayColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '₹${userDetailsController.totalProductPriceWithoutDiscount.toStringAsFixed(1)}',
                          style: CustomeTextStyle.productName
                              .copyWith(fontSize: 16),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total discount : ',
                          style: TextStyle(
                            color: AppColors.grayColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "₹${userDetailsController.discountPrice.toStringAsFixed(2)}",
                          style: CustomeTextStyle.productName.copyWith(
                              fontSize: 16, color: AppColors.grayColor),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery charge : ',
                          style: CustomeTextStyle.productName
                              .copyWith(color: AppColors.grayColor),
                        ),
                        const Spacer(),
                        Text(
                          '₹50',
                          style: userDetailsController.totalProductPrice < 2000
                              ? CustomeTextStyle.productName
                              : CustomeTextStyle.productName.copyWith(
                                  color: AppColors.grayColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                        ),
                        if (userDetailsController.totalProductPrice > 2000)
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child:
                                Text('₹0', style: CustomeTextStyle.productName),
                          ),
                      ],
                    ),
                    if (userDetailsController.isPromoCodeUsed)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Promo code discount : ',
                            style: CustomeTextStyle.productName
                                .copyWith(color: AppColors.grayColor),
                          ),
                          const Spacer(),
                          Text('${userDetailsController.promoCodeDiscount}',
                              style: CustomeTextStyle.productName),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'To pay : ',
                  style: CustomeTextStyle.productName
                      .copyWith(color: AppColors.grayColor),
                ),
                Consumer<UserDetailsViewModel>(
                  builder: (context, value, child) => Text(
                    value.totalProductPrice < 2000
                        ? '₹${value.totalProductPrice + 50}'
                        : '₹${value.totalProductPrice}',
                    style: CustomeTextStyle.productName,
                  ),
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

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const ProductCheckOutPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
