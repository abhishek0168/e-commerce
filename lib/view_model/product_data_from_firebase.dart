import 'dart:developer';

import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:flutter/material.dart';

class DataFromFirebase extends ChangeNotifier {
//variables

  List<ProductModel> productsData = [];
  List<ProductModel> womenProductDatas = [];
  List<ProductModel> menProductDatas = [];
  List<ProductModel> selectedProductsData = [];

// instances

  final productServices = FirebaseProductServices();

// Functions
  // void init() async {
  //   await callPrductDetails();
  //   selectedProductsData = productsData;
  // }

  Future<List<ProductModel>> callPrductDetails() async {
    productsData = await productServices.getProductDetails();
    log('$productsData product details callProductDetails()');
    selectedProductsData = productsData;
    // notifyListeners();
    return productsData;
  }

  Future<void> callSelectedProductDetails(String value) async {
    selectedProductsData =
        await productServices.getSelectedProductDetails(value);
    notifyListeners();
  }
}
