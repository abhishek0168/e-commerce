import 'dart:developer';
import 'dart:io';

import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProductServices {
  Future<List<String>> uploadImageToStorage(List<File> images) async {
    List<String> imageUrls = [];
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('product_images');
    Reference refernceImageToUpload = referenceDirImages.child(uniqueFileName);

    for (var image in images) {
      try {
        await refernceImageToUpload.putFile(image);
        imageUrls.add(await refernceImageToUpload.getDownloadURL());
      } catch (e) {
        log('Image uploading error\n$e');
      }
    }

    return imageUrls;
  }

  Future<void> uploadDataToDatabase(ProductModel model) async {
    final productDoc = FirebaseFirestore.instance.collection('Products').doc();
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
}
