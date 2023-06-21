import 'dart:developer';

import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/model/user_model/user_model.dart';
import 'package:ecommerce_app/services/firebase_user_services.dart';
import 'package:flutter/foundation.dart';

class UserDetailsViewModel extends ChangeNotifier {
  List<String> userCart = [];
  List<String> userFavs = [];

  UserModel? userData;
  int totalProductPrice = 0;
  List<ProductModel> productData = [];

  // instances
  final firebaseUserService = FirebaseUserDetails();

  Future<void> init() async {
    await fetchingUserData();
  }

  Future<void> fetchingUserData() async {
    userData = await firebaseUserService.getUserDetails();

    if (userData != null) {
      userCart = userData!.userCart!.map((e) => e.toString()).toList();
      userFavs = userData!.userFavList!.map((e) => e.toString()).toList();
      log(
        'fetchingUserData()=> ${userData!.userName}',
      );
      log('fetchingUserData()=> ${userData!.userEmail}');
      log('fetchingUserData()=> $userCart');
      log('fetchingUserData()=> $userFavs');
    } else {
      log('fetchingUserData()=> User is empty');
    }
    notifyListeners();
  }

  Future<void> addToCart(String productId) async {
    if (userCart.contains(productId)) {
      userCart.remove(productId);
    } else {
      userCart.add(productId);
    }
    await firebaseUserService.updateUserCart(userCart, userData!.id);
    fetchingUserData();
    notifyListeners();
  }

  void getCartProducts(List<ProductModel> productList) {
    totalProductPrice = 0;
    productData =
        productList.where((product) => userCart.contains(product.id)).toList();
    for (var product in productData) {
      totalProductPrice += product.productDiscountedprice;
    }

    log('getCartProducts()=> $totalProductPrice');
    // notifyListeners();
  }

  void addtoFav(String productId) {
    if (userFavs.contains(productId)) {
      userFavs.remove(productId);
    } else {
      userFavs.add(productId);
    }
    firebaseUserService.updateUserFav(userFavs, userData!.id);
    notifyListeners();
  }
}
