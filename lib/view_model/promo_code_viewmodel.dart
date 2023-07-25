import 'package:ecommerce_app/model/promo_code_model/promo_code_model.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum PromoCodeStatus {
  available,
  unavailable,
}

class PromoCodeViewModel extends ChangeNotifier {
  final createdDateController = TextEditingController();
  final expiryDteController = TextEditingController();
  final discountController = TextEditingController();
  final promoCodeKeyController = TextEditingController();
  DateTime? expiryDate;
  PromoCodeStatus status = PromoCodeStatus.available;
  bool isLoading = false;
  List<PromoCodeModel> promoCodes = [];

  // instances
  final productServices = FirebaseProductServices();
  final userDetailsModel = UserDetailsViewModel();

  Future<void> init() async {
    promoCodes = await productServices.getPromoCodes();
  }

  Future<List<PromoCodeModel>> getPromoCodes() async {
    promoCodes = await productServices.getPromoCodes();
    return promoCodes;
  }

  void pickupExpiryDate(
    BuildContext context,
  ) {
    var dateNow = DateTime.now();
    showDatePicker(
      context: context,
      initialDate: dateNow,
      firstDate: dateNow,
      lastDate: DateTime(dateNow.year + 3),
    ).then(
      (value) {
        if (value != null) {
          expiryDate = value;
        }
        notifyListeners();
      },
    );
  }

  void statusChange(value) {
    status = value;
    notifyListeners();
  }

  void promoCodeToTextField(String promocode) {
    promoCodeKeyController.text = promocode;
    notifyListeners();
  }

  void clearForm() {
    createdDateController.clear();
    expiryDteController.clear();
    promoCodeKeyController.clear();
    discountController.clear();
    expiryDate = null;
    status = PromoCodeStatus.available;
    notifyListeners();
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<String?> addCoupon() async {
    if (promoCodes.any(
      (element) =>
          element.promoCode.toLowerCase() ==
          promoCodeKeyController.text.trim().toLowerCase(),
    )) {
      return 'This promo code alredy exits';
    }
    changeLoading();
    Future.delayed(const Duration(seconds: 3));

    final promoCodeDetails = PromoCodeModel(
      id: '',
      createdDate: DateTime.now().toString(),
      expiryDate: DateFormat('dd-MM-yyyy').format(expiryDate!).toString(),
      promoCode: promoCodeKeyController.text.trim(),
      status: status == PromoCodeStatus.available ? true : false,
      discount: int.parse(discountController.text.trim()),
      usedUsers: [],
    );

    await productServices.uploadPromoCodeToDatabase(promoCodeDetails);
    promoCodes = await productServices.getPromoCodes();
    clearForm();
    changeLoading();
    notifyListeners();
    return null;
  }
}
