import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String productName;
  final String productPrice;
  final String brandName;
  final String gender;
  final Map<String, dynamic> productSizes;
  final String productColor;
  final int productStock;
  final int productDiscount;
  final int productDiscountedprice;
  final String productCategory;
  final List<dynamic> productImages;
  final bool status;

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
    required this.productDiscountedprice,
    required this.productCategory,
    required this.productImages,
    required this.status,
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
        'productDiscountedprice': productDiscountedprice,
        'productCategory': productCategory,
        'productImages': productImages,
        'status': status,
      };

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return ProductModel(
      id: document.id,
      productName: data!['productName'],
      productPrice: data['productPrice'],
      brandName: data['brandName'],
      gender: data['gender'],
      productSizes: data['productSizes'],
      productColor: data['productColor'],
      productStock: data['productStock'],
      productDiscount: data['productDiscount'],
      productDiscountedprice: data['productDiscountedprice'],
      productCategory: data['productCategory'],
      productImages: data['productImages'],
      status: data['status'],
    );
  }
}
