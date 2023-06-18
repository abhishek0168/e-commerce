import 'package:flutter/material.dart';
import 'package:ecommerce_app/model/product_model/product_model.dart';
class ShopViewModel extends ChangeNotifier {
  final Set<String> filter = {};

  void changeSelection(bool selected, String value) {
    if (selected) {
      filter.add(value);
    } else {
      filter.remove(value);
    }
    notifyListeners();
  }

  int findDiscountPrice(int price, int discount) {
    int productDiscountPrice = (price - ((discount / 100) * price)).toInt();
    return productDiscountPrice;
  }

  toCart(ProductModel product){

  }
}
