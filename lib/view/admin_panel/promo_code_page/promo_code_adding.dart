import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/admin_panel/product_page/admin_text_form_widget.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/custome_snackBar.dart';
import 'package:ecommerce_app/view/widgets/three_dot_loading.dart';
import 'package:ecommerce_app/view_model/promo_code_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PromoCodeAddingPage extends StatelessWidget {
  PromoCodeAddingPage({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final promoCodeModel = Provider.of<PromoCodeViewModel>(context);
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add coupon'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AdminTextForm(
                    controller: promoCodeModel.promoCodeKeyController,
                    title: 'Promo code',
                  ),
                  AdminTextForm(
                    controller: promoCodeModel.discountController,
                    title: 'Discount (in percentage)',
                  ),
                  height10,
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Select expiry date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(flex: 2, child: Divider()),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            promoCodeModel.pickupExpiryDate(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: (80 / 100) * screenSize.width,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Consumer<PromoCodeViewModel>(
                              builder: (context, value, _) => Text(
                                value.expiryDate == null
                                    ? 'Select expiry date'
                                    : DateFormat('dd-MM-yyyy')
                                        .format(value.expiryDate!),
                              ),
                            ),
                          ),
                        ),
                        IconButton.filled(
                          tooltip: 'Select Date',
                          onPressed: () {
                            promoCodeModel.pickupExpiryDate(context);
                          },
                          icon: const Icon(Icons.calendar_month_rounded),
                          style: const ButtonStyle(
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Consumer<PromoCodeViewModel>(
                    builder: (context, value, child) => Row(
                      children: [
                        Flexible(
                          child: RadioListTile<PromoCodeStatus>(
                            value: PromoCodeStatus.available,
                            groupValue: value.status,
                            onChanged: (status) {
                              value.statusChange(status);
                            },
                            title: const Text('available'),
                          ),
                        ),
                        Flexible(
                          child: RadioListTile<PromoCodeStatus>(
                            value: PromoCodeStatus.unavailable,
                            groupValue: value.status,
                            onChanged: (status) {
                              value.statusChange(status);
                            },
                            title: const Text('unavailable'),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton(
                        onPressed: () async {
                          String? message;
                          if (promoCodeModel.expiryDate == null) {
                            final snackbar = CustomeSnackBar().snackBar1(
                              bgColor: AppColors.primaryColor,
                              content: 'Select expiry date',
                              textColor: AppColors.whiteColor,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          }
                          if (_formKey.currentState!.validate() &&
                              promoCodeModel.expiryDate != null) {
                            message = await promoCodeModel.addCoupon();
                          }

                          if (message != null && context.mounted) {
                            final snackbar = CustomeSnackBar().snackBar1(
                              bgColor: AppColors.primaryColor,
                              content: message,
                              textColor: AppColors.whiteColor,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(AppColors.sumbitColor),
                        ),
                        child: const Text('Submit'),
                      ),
                      width20,
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Consumer<PromoCodeViewModel>(
            builder: (context, value, child) => Visibility(
              visible: value.isLoading,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: AppColors.grayColor.withOpacity(0.4),
                child: threeDotLoadingAnimation(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
