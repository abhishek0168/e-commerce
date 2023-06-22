import 'dart:developer';

import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/model/user_model/user_model.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/services/firebase_user_services.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view_model/product_data_from_firebase.dart';
import 'package:flutter/material.dart';

class UserDetailsViewModel extends ChangeNotifier {
  List<String> userCart = [];
  List<String> userFavs = [];

  UserModel? userData;
  int totalProductPrice = 0;
  List<ProductModel> cartProductData = [];
  List<ProductModel> favProductData = [];
  List<ProductModel> totalProductData = [];

  // instances
  final firebaseUserService = FirebaseUserDetails();
  final dataFromFirebase = DataFromFirebase();
  final productServices = FirebaseProductServices();

  Future<void> init() async {
    totalProductData = await productServices.getProductDetails();
    await fetchingUserData();
  }

  Future<void> fetchingUserData() async {
    userData = await firebaseUserService.getUserDetails();

    if (userData != null) {
      userCart = userData!.userCart!.map((e) => e.toString()).toList();
      userFavs = userData!.userFavList!.map((e) => e.toString()).toList();
      log('fetchingUserData()=> name : ${userData!.userName}');
      log('fetchingUserData()=> id : ${userData!.id}');
      log('fetchingUserData()=> email : ${userData!.userEmail}');
      log('fetchingUserData()=> cart : $userCart');
      log('fetchingUserData()=> fav : $userFavs');
      log('fetchingUserData()=> Total product data : $totalProductData');
    } else {
      log('fetchingUserData()=> User is empty');
    }
    cartProductData = sortProducts(userCart);
    cartTotalPrice();
    favProductData = sortProducts(userFavs);
    notifyListeners();
  }

  Future<void> addToCart(String productId) async {
    userData = await firebaseUserService.getUserDetails();
    if (userCart.contains(productId)) {
      userCart.remove(productId);
    } else {
      if (userFavs.contains(productId)) {
        userFavs.remove(productId);
        log('addToCart()=> fav : $userFavs');
        await firebaseUserService.updateUserFav(userFavs, userData!.id);
      }
      userCart.add(productId);
    }
    await firebaseUserService.updateUserCart(userCart, userData!.id);
    await fetchingUserData();
    notifyListeners();
  }

  List<ProductModel> sortProducts(List<String> userCart) {
    final tempList = totalProductData
        .where((product) => userCart.contains(product.id))
        .toList();

    log('getCartProducts()=> $totalProductPrice');
    return tempList;
  }

  void cartTotalPrice() {
    totalProductPrice = 0;
    for (var product in cartProductData) {
      totalProductPrice += product.productDiscountedprice;
    }
  }

  void addtoFav(String productId, BuildContext context) async {
    if (userCart.contains(productId)) {
      final snackBar = SnackBar(
        showCloseIcon: true,
        closeIconColor: AppColors.blackColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: const Text(
          'Product is alredy in cart!',
          style: TextStyle(
            color: AppColors.blackColor,
          ),
        ),
        backgroundColor: AppColors.starColor,
        dismissDirection: DismissDirection.up,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      if (userFavs.contains(productId)) {
        userFavs.remove(productId);
      } else {
        userFavs.add(productId);
      }
      log('addtoFav()=> fav : $userFavs');
    }
    await firebaseUserService.updateUserFav(userFavs, userData!.id);
    await fetchingUserData();
    notifyListeners();
  }
}
