import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/stripe_key.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentViewModel extends ChangeNotifier {
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(BuildContext context, String amount) async {
    try {
      loadingIdicator(context);
      paymentIntent = await createPaymentIntent(amount);
      if (context.mounted) {
        Navigator.pop(context);
      }
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Abhishek'))
          .then((value) {});
      if (context.mounted) {
        await displayPaymentSheet(context);
      }
    } catch (e, s) {
      log('Makepayment => $e\n$s');
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(String amount) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': 'INR',
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $SECRET_KEY',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      log('createPayment => ${response.body}');
      return jsonDecode(response.body);
    } catch (e) {
      log('createPayment => Error\n$e');
      return null;
    }
  }

  String calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount) * 100);
    return calculatedAmount.toString();
  }

  Future<void> displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: AppColors.sumbitColor,
                ),
                const Text('Payment Successfull'),
              ],
            ),
          ),
        );
        
        paymentIntent = null;
      }).onError((error, stackTrace) {
        log('displayPaymentSheet => Error $error\n$stackTrace');
      });
    } on StripeException catch (e) {
      log('displayPaymentSheet => Error $e');
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text('Cancelled'),
        ),
      );
    } catch (e) {
      log('displayPaymentSheet => Error $e');
    }
  }
}
