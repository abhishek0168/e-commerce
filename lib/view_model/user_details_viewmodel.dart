import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/order_model/order_model.dart';
import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/model/promo_code_model/promo_code_model.dart';
import 'package:ecommerce_app/model/user_model/user_model.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/services/firebase_user_services.dart';
import 'package:ecommerce_app/services/user_auth.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view_model/product_data_from_firebase.dart';
import 'package:ecommerce_app/view_model/user_address_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserDetailsViewModel extends ChangeNotifier {
  List<Map<dynamic, dynamic>> userCart = [];
  List<String> userFavs = [];
  List<UserModel> usersList = [];
  UserModel? userData;
  int totalProductPrice = 0;
  double totalProductPriceWithoutDiscount = 0;
  double discountPrice = 0;
  List<ProductModel> cartProductData = [];
  List<ProductModel> favProductData = [];
  List<ProductModel> totalProductData = [];
  List<OrderModel> totalOrderList = [];
  String? selectedSize;
  int sizeIsSelected = -1;
  bool isLoading = false;
  ScrollController cartScrollContoller = ScrollController();
  bool cartIsScrolling = true;
  bool isPromoCodeUsed = false;
  String usedPromoCode = '';
  int promoCodeDiscount = 0;

  // instances
  final firebaseUserService = FirebaseUserDetails();
  final dataFromFirebase = DataFromFirebase();
  final productServices = FirebaseProductServices();
  final userAuth = UserAuthFirebase();
  // final addressModel = AddressViewModel();

  Future<void> init() async {
    totalProductData = await productServices.getProductDetails();
    await fetchingUserData();
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void cartScrollDown() {
    cartIsScrolling = false;
    notifyListeners();
  }

  void cartScrollUp() {
    cartIsScrolling = true;
    notifyListeners();
  }

  Future<UserModel?> getUser() async {
    return userData = await firebaseUserService.getUserDetails();
  }

  Future<List<UserModel>> getAllUsers() async {
    usersList = await firebaseUserService.getAllUsers();
    return usersList;
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

      totalOrderList = userData!.userOrders!
          .map((e) => OrderModel(
                id: e['id'],
                amount: e['amount'],
                address: e['address'],
                cartDetails: e['cartDetails'],
                date: e['date'],
              ))
          .toList();
      // final bahu = userData!.userStatus;
      userFavs = userData!.userFavList!.map((e) => e.toString()).toList();

      log('fetchingUserData()=> name : ${userData!.userName}');
      log('fetchingUserData()=> id : ${userData!.id}');
      log('fetchingUserData()=> email : ${userData!.userEmail}');
      log('fetchingUserData()=> status : ${userData!.userStatus}');
      log('fetchingUserData()=> fav : $userFavs');
      log('fetchingUserData()=> cart : $userCart');
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
    required BuildContext context,
  }) async {
    loadingIdicator(context);
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
    if (userCart.length <= 4) cartIsScrolling = true;
    if (context.mounted) {
      Navigator.pop(context);
    }

    notifyListeners();
  }

  Future<void> clearUserCart(UserAddress selectedAddress) async {
    String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    totalOrderList.add(
      OrderModel(
        id: 'id',
        amount: totalProductPrice.toString(),
        address: selectedAddress.toJson(),
        cartDetails: userCart,
        date: date,
      ),
    );
    List<Map<dynamic, dynamic>> orderList = totalOrderList
        .map((e) => {
              'id': e.id,
              'amount': e.amount,
              'address': e.address,
              'cartDetails': e.cartDetails,
              'date': e.date,
            })
        .toList();
    await firebaseUserService.updateUserOrder(orderList, userData!.id);
    userCart.clear();
    cartProductData.clear();
    await firebaseUserService.updateUserCart(userCart, userData!.id);
    await fetchingUserData();
    log('cartProductData $cartProductData');
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

  void cartTotalPrice() {
    totalProductPrice = 0;
    discountPrice = 0;
    totalProductPriceWithoutDiscount = 0;
    for (var product in cartProductData) {
      for (var cartProduct in userCart) {
        if (product.id == cartProduct['id']) {
          final productCount = cartProduct['count'] as int;
          double productPrice = double.parse(product.productPrice);
          discountPrice +=
              productCount * ((product.productDiscount / 100) * productPrice);

          totalProductPriceWithoutDiscount += (productPrice * productCount);
          totalProductPrice += (product.productDiscountedprice * productCount);
        }
      }
    }
  }

  Future<void> updateCartCount({
    required int count,
    required Map<dynamic, dynamic> prodcutDetails,
    required BuildContext context,
  }) async {
    loadingIdicator(context);
    userCart.remove(prodcutDetails);
    final data = {
      'id': prodcutDetails['id'],
      'count': count,
      'color': prodcutDetails['color'],
      'size': prodcutDetails['size'],
    };
    userCart.add(data);
    await firebaseUserService.updateUserCart(userCart, userData!.id);
    await fetchingUserData();
    if (context.mounted) {
      Navigator.pop(context);
    }
    notifyListeners();
  }

  List<ProductModel> sortFavProducts(List<String> favList) {
    final tempList = totalProductData
        .where((element) => favList.contains(element.id))
        .toList();
    return tempList;
  }

  void addtoFav(String productId, BuildContext context) async {
    loadingIdicator(context);
    if (userFavs.contains(productId)) {
      userFavs.remove(productId);
    } else {
      userFavs.add(productId);
    }
    log('addtoFav()=> fav : $userFavs');

    await firebaseUserService.updateUserFav(userFavs, userData!.id);
    await fetchingUserData();
    if (context.mounted) {
      Navigator.pop(context);
    }
    notifyListeners();
  }

  void changeSize(bool value, int index, String productSize) {
    sizeIsSelected = value ? index : -1;
    selectedSize = productSize;
    notifyListeners();
  }

  Future<void> userStatus(String userId, bool userStatus) async {
    changeLoading();
    await firebaseUserService.changeUserStatus(!userStatus, userId);

    usersList = await firebaseUserService.getAllUsers();
    changeLoading();
    notifyListeners();
  }

  String checkPromoCode(
      String promoCode, String userId, List<PromoCodeModel> promoCodeList) {
    bool isPresent =
        promoCodeList.any((element) => element.promoCode == promoCode);
    if (isPresent) {
      PromoCodeModel promoModel = promoCodeList
          .where((element) => element.promoCode == promoCode)
          .single;
      if (!promoModel.usedUsers.contains(userId) &&
          usedPromoCode != promoCode) {
        cartTotalPrice();
        usedPromoCode = promoCode;
        isPromoCodeUsed = true;
        log(totalProductPrice.toString());
        promoCodeDiscount =
            ((promoModel.discount / 100) * totalProductPrice).toInt();
        totalProductPrice -= promoCodeDiscount;
        notifyListeners();
        return 'Promo code added successfully';
      } else {
        return 'This promo code alredy used';
      }
    } else {
      return 'This promo code does not exist';
    }
  }

  void removePromoCode() {
    cartTotalPrice();
    isPromoCodeUsed = false;
    usedPromoCode = '';
    promoCodeDiscount = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    cartScrollContoller.dispose();
    super.dispose();
  }
}
