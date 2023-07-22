import 'dart:developer';

import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';

enum ChooseShopPage {
  all,
  men,
  women,
}

enum SortProductBy {
  name,
  price,
  discount,
}

class DataFromFirebase extends ChangeNotifier {
//variables

  List<ProductModel> productsData = [];
  List<ProductModel> womenProductDatas = [];
  List<ProductModel> menProductDatas = [];
  List<ProductModel> selectedProductsData = [];
  var selectedPage = ChooseShopPage.all;
  SortProductBy? sortValue;

// instances

  final productServices = FirebaseProductServices();

  Future<List<ProductModel>> callPrductDetails() async {
    productsData = await productServices.getProductDetails();
    log('$productsData product details callProductDetails()');
    selectedProductsData = productsData;
    // notifyListeners();
    return productsData;
  }

  Future<List<ProductModel>> callSelectedProductDetails(String value) async {
    selectedProductsData =
        await productServices.getSelectedProductDetails(value);
    notifyListeners();
    return selectedProductsData;
  }

  Future<void> sortOnPress(SortProductBy value, BuildContext context) async {
    loadingIdicator(context);
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    sortValue = value;
    await sortProducts();
    if (context.mounted) {
      Navigator.pop(context);
    }
    notifyListeners();
  }

  Future<List<ProductModel>> sortProducts() async {
    List<ProductModel> productList;

    switch (selectedPage) {
      case ChooseShopPage.men:
        log('Male selected');
        return productList = await callSelectedProductDetails('Male');
      case ChooseShopPage.women:
        log('Female selected');
        return productList = await callSelectedProductDetails('Female');
      default:
        log('all selected');
        productList = await callPrductDetails();
    }

    switch (sortValue) {
      case SortProductBy.name:
        log('name selected');
        productList.sort((a, b) => a.brandName.compareTo(b.brandName));
        break;
      case SortProductBy.price:
        log('price selected');
        productList.sort((a, b) =>
            a.productDiscountedprice.compareTo(b.productDiscountedprice));
        break;
      case SortProductBy.discount:
        log('discount selected');
        productList
            .sort((a, b) => b.productDiscount.compareTo(a.productDiscount));
        break;
      default:
        log('null selected');
    }
    for (var e in productList) {
      log(e.brandName);
    }
    return productList;
  }
}
