import 'dart:developer';

import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/model/user_model/user_model.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/services/firebase_user_services.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view_model/product_data_from_firebase.dart';
import 'package:flutter/material.dart';

class UserDetailsViewModel extends ChangeNotifier {
  List<Map<dynamic, dynamic>> userCart = [];
  List<String> userFavs = [];

  UserModel? userData;
  int totalProductPrice = 0;
  List<ProductModel> cartProductData = [];
  List<ProductModel> favProductData = [];
  List<ProductModel> totalProductData = [];
  String? selectedSize;
  int sizeIsSelected = -1;

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
      userCart = userData!.userCart!
          .map((e) => {
                'id': e['id'],
                'count': e['count'],
                'color': e['color'],
                'size': e['size']
              })
          .toList();
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
    cartProductData = sortCartProducts(userCart);
    cartTotalPrice();
    favProductData = sortFavProducts(userFavs);
    notifyListeners();
  }

  Future<void> addToCart({
    required String productId,
    required String color,
    required String size,
    required int count,
  }) async {
    userData = await firebaseUserService.getUserDetails();

    bool productStatus = userCart.any((element) => element['id'] == productId);

    if (productStatus) {
      userCart.removeWhere((element) => element['id'] == productId);
    } else {
      final toMap = {
        'id': productId,
        'count': count,
        'color': color,
        'size': size,
      };
      userCart.add(toMap);
    }

    await firebaseUserService.updateUserCart(userCart, userData!.id);
    selectedSize = null;
    await fetchingUserData();
    notifyListeners();
  }

  List<ProductModel> sortCartProducts(List<Map<dynamic, dynamic>> userCart) {
    Map<dynamic, dynamic> cartMap = {};
    for (var element in userCart) {
      cartMap[element['id']] = true;
    }

    List<ProductModel> tempList = [];
    for (var product in totalProductData) {
      if (cartMap.containsKey(product.id)) {
        tempList.add(product);
      }
    }

    log('getCartProducts()=> $totalProductPrice');
    return tempList;
  }

  List<ProductModel> sortFavProducts(List<String> favList) {
    final tempList = totalProductData
        .where((element) => favList.contains(element.id))
        .toList();
    return tempList;
  }

  void cartTotalPrice() {
    totalProductPrice = 0;
    for (var product in cartProductData) {
      totalProductPrice += product.productDiscountedprice;
    }
  }

  void addtoFav(String productId, BuildContext context) async {
    if (userFavs.contains(productId)) {
      userFavs.remove(productId);
    } else {
      userFavs.add(productId);
    }
    log('addtoFav()=> fav : $userFavs');

    await firebaseUserService.updateUserFav(userFavs, userData!.id);
    await fetchingUserData();
    notifyListeners();
  }

  void changeSize(bool value, int index, String productSize) {
    sizeIsSelected = value ? index : -1;
    selectedSize = productSize;
    notifyListeners();
  }
}
