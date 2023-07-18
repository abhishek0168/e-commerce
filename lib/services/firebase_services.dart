import 'dart:developer';
import 'dart:io';

import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/model/promo_code_model/promo_code_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProductServices {
  final _db = FirebaseFirestore.instance;

  Future<List<String>> uploadImageToStorage(List<File> images) async {
    List<String> imageUrls = [];
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('product_images');

    for (var image in images) {
      String imageName = image.path.split('/').last;
      imageName = imageName.substring(0, imageName.length - 4);

      try {
        Reference refernceImageToUpload =
            referenceDirImages.child('$imageName$uniqueFileName');
        await refernceImageToUpload.putFile(image);
        imageUrls.add(await refernceImageToUpload.getDownloadURL());
      } catch (e) {
        log('Image uploading error\n$e');
      }
    }

    return imageUrls;
  }

  Future<void> uploadDataToDatabase(ProductModel model) async {
    final productDoc = _db.collection('Products').doc();
    final productData = ProductModel(
      id: productDoc.id,
      productName: model.productName,
      productPrice: model.productPrice,
      brandName: model.brandName,
      gender: model.gender,
      productSizes: model.productSizes,
      productColor: model.productColor,
      productStock: model.productStock,
      productDiscount: model.productDiscount,
      productDiscountedprice: model.productDiscountedprice,
      productCategory: model.productCategory,
      productImages: model.productImages,
      status: model.status,
    );

    final dataModel = productData.toJson();
    await productDoc.set(dataModel);
  }

  Future<void> updateProductSize(
      {required String productId,
      required Map<dynamic, dynamic> updatedSizes,
      required int totalCount}) async {
    final productDoc = _db.collection('Products').doc(productId);
    final updatedJson = {
      'productSizes': updatedSizes,
    };
    final updatedJsonTotalStock = {
      'productStock': totalCount,
    };

    await productDoc
        .update(updatedJson)
        .then((value) => log('product size updated'));
    await productDoc
        .update(updatedJsonTotalStock)
        .then((value) => log('product total stock updated'));
  }

  Future<void> uploadPromoCodeToDatabase(PromoCodeModel model) async {
    final promoDoc = _db.collection('Promocodes').doc();
    final promoCodeData = PromoCodeModel(
      id: promoDoc.id,
      createdDate: model.createdDate,
      expiryDate: model.expiryDate,
      promoCode: model.promoCode,
      status: model.status,
      discount: model.discount,
      usedUsers: model.usedUsers,
    );

    final dataModel = promoCodeData.toJson();
    await promoDoc.set(dataModel);
  }

  updatePromoCode(
      {required String promoCodeId, required List<String> usedUsers}) async {
    final promoDoc = _db.collection('Promocodes').doc(promoCodeId);
    Map<String, dynamic> updatedJson = {'usedUsers': usedUsers};
    await promoDoc.update(updatedJson).then(
          (value) => log('promocode updated'),
        );
  }

  Future<void> updateDatabase(ProductModel model) async {
    final productDoc = _db.collection('Products').doc(model.id);
    final productData = ProductModel(
      id: model.id,
      productName: model.productName,
      productPrice: model.productPrice,
      brandName: model.brandName,
      gender: model.gender,
      productSizes: model.productSizes,
      productColor: model.productColor,
      productStock: model.productStock,
      productDiscount: model.productDiscount,
      productDiscountedprice: model.productDiscountedprice,
      productCategory: model.productCategory,
      productImages: model.productImages,
      status: model.status,
    );

    final dataModel = productData.toJson();
    await productDoc.update(dataModel);
  }

  Future<List<ProductModel>> getProductDetails() async {
    final productDetails = await _db.collection('Products').get();

    final productData =
        productDetails.docs.map((e) => ProductModel.fromSnapshot(e)).toList();

    return productData;
  }

  Future<List<PromoCodeModel>> getPromoCodes() async {
    final promoCodes = await _db.collection('Promocodes').get();
    final promoCodeData =
        promoCodes.docs.map((e) => PromoCodeModel.fromSnapshot(e)).toList();
    log('getPromoCodes()=> promocode list : $promoCodeData');
    return promoCodeData;
  }

  Future<List<ProductModel>> getSelectedProductDetails(String value) async {
    final productDetails = await _db
        .collection('Products')
        .where('gender', isEqualTo: value)
        .get();
    final productData =
        productDetails.docs.map((e) => ProductModel.fromSnapshot(e)).toList();

    return productData;
  }
}
