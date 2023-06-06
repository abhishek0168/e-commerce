import 'dart:io';

class ProductModel {
  final String id;
  final String productName;
  final String productPrice;
  final String brandName;
  final String gender;
  final Map<String, int> productSizes;
  final String productColor;
  final int productStock;
  final int productDiscount;
  final String productCategory;
  final List<String> productImages;

  ProductModel({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.brandName,
    required this.gender,
    required this.productSizes,
    required this.productColor,
    required this.productStock,
    required this.productDiscount,
    required this.productCategory,
    required this.productImages,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'productName': productName,
        'productPrice': productPrice,
        'brandName': brandName,
        'gender': gender,
        'productSizes': productSizes,
        'productColor': productColor,
        'productStock': productStock,
        'productDiscount': productDiscount,
        'productCategory': productCategory,
        'productImages': productImages,
      };
}
