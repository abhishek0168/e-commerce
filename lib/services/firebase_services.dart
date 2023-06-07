import 'dart:developer';
import 'dart:io';

import 'package:ecommerce_app/model/product_model/product_model.dart';
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
      productCategory: model.productCategory,
      productImages: model.productImages,
    );

    final dataModel = productData.toJson();
    await productDoc.set(dataModel);
  }

  Future<List<ProductModel>> getProductDetails() async {
    final productDetails = await _db.collection('Products').get();
    final productData =
        productDetails.docs.map((e) => ProductModel.fromSnapshot(e)).toList();

    return productData;
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
