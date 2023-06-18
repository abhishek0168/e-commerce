import 'dart:developer';

import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/model/user_model/user_model.dart';
import 'package:ecommerce_app/services/firebase_user_services.dart';
import 'package:flutter/foundation.dart';

class UserDetailsViewModel extends ChangeNotifier {
  List<String> userCart = [];
  List<String> userFavs = [];
  String userName = '';
  String userEmail = '';
  String userId = '';
  UserModel? userData;
  int totalProductPrice = 0;

  // instances
  final firebaseUserService = FirebaseUserDetails();

  Future<void> init() async {
    await fetchingUserData();
  }

  Future<void> fetchingUserData() async {
    userData = await firebaseUserService.getUserDetails();

    if (userData != null) {
      userName = userData!.userName;
      userEmail = userData!.userEmail;
      userId = userData!.id;
      userCart = userData!.userCart!.map((e) => e.toString()).toList();
      userFavs = userData!.userFavList!.map((e) => e.toString()).toList();
      log('$userCart fetchingUserData()=>');
      log('$userFavs fetchingUserData()=>');
    } else {
      log('User is empty fetchingUserData()=>');
    }
    notifyListeners();
  }

  Future<void> addToCart(String productId) async {
    if (userCart.contains(productId)) {
      userCart.remove(productId);
    } else {
      userCart.add(productId);
    }
    await firebaseUserService.updateUserCart(userCart, userId);
    fetchingUserData();
    notifyListeners();
  }

  List<ProductModel> getCartProducts(List<ProductModel> productList) {
    List<ProductModel> productData = [];
    try {
      totalProductPrice = 0;
      productData = productList
          .where((product) => userCart.contains(product.id))
          .toList();
      for (var product in productData) {
        totalProductPrice += product.productDiscountedprice;
      }
      // notifyListeners();
    } catch (e) {
      log('$e error from getCartProducts()=>');
    }
    return productData;
  }
}
