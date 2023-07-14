import 'package:ecommerce_app/view_model/product_data_from_firebase.dart';
import 'package:ecommerce_app/view_model/promo_code_viewmodel.dart';
import 'package:ecommerce_app/view_model/user_address_viewmodel.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';

class MainPageViewModel extends ChangeNotifier {
  final userDetails = UserDetailsViewModel();
  final firebaseData = DataFromFirebase();
  final promoCodeModel = PromoCodeViewModel();
  final addressViewModel = AddressViewModel();

  void init() async {
    await userDetails.init();
    firebaseData.init();
    promoCodeModel.init();
    await addressViewModel.init();
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  bool isScrolling = true;

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
