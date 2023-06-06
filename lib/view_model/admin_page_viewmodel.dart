import 'dart:developer';
import 'dart:io';

import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/services/fire_base_services.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminPageViewModel extends ChangeNotifier {
  // textediting controllers
  final productName = TextEditingController();
  final productPrice = TextEditingController();
  final brandName = TextEditingController();
  final productColor = TextEditingController();
  final productStock = TextEditingController(text: '0');
  final productDiscount = TextEditingController(text: '0');
  final productSizeS = TextEditingController(text: '0');
  final productSizeM = TextEditingController(text: '0');
  final productSizeL = TextEditingController(text: '0');
  final productSizeXL = TextEditingController(text: '0');

// variables
  List<File> images = [];

  String genderDropDownValue = 'Male';
  final List<String> genderItemValues = ['Male', 'Female'];

  String categoryDropValue = 'shirt';
  final List<String> categories = [
    'shirt',
    'T-shirt',
    'Jeans',
    'Shorts',
    'Skirt',
  ];
// functions

  // image sectoin

  void imageErrorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Add images',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primaryColor,
        showCloseIcon: true,
        dismissDirection: DismissDirection.up,
      ),
    );
  }

  void chooseImage() async {
    final pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      images.add(File(pickImage.path));
      log(pickImage.path);
    }
    notifyListeners();
  }

  void removeImage(File image) {
    images.remove(image);
    notifyListeners();
  }

  //Dropdown section

  void onGenderChange(String value) {
    genderDropDownValue = value;
    notifyListeners();
  }

  void onCategoryChange(String value) {
    categoryDropValue = value;
    notifyListeners();
  }

  //stock section

  void totalStock() {
    productStock.text =
        '${int.parse(productSizeS.text) + int.parse(productSizeM.text) + int.parse(productSizeL.text) + int.parse(productSizeXL.text)}';
  }

  //button section

  Future<void> showAlertBox(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Clear form'),
        content: const Text('Are you sure you want to clear this form ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              clearValues();
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void clearValues() {
    images.clear();
    productName.clear();
    productPrice.clear();
    brandName.clear();
    productColor.clear();
    productStock.clear();
    productDiscount.clear();
    productSizeS.clear();
    productSizeM.clear();
    productSizeL.clear();
    productSizeXL.clear();

    notifyListeners();
  }

  Future<void> uploadValues() async {
    List<String> imageUrls;
    final productServices = FirebaseProductServices();

    imageUrls = await productServices.uploadImageToStorage(images);
    final productModel = ProductModel(
      id: '',
      productName: productName.text,
      productPrice: productPrice.text,
      brandName: brandName.text,
      gender: genderDropDownValue,
      productSizes: {
        'S': int.parse(productSizeS.text),
        'M': int.parse(productSizeM.text),
        'L': int.parse(productSizeL.text),
        'XL': int.parse(productSizeXL.text),
      },
      productColor: productColor.text,
      productStock: int.parse(productStock.text),
      productDiscount: int.parse(productDiscount.text),
      productCategory: categoryDropValue,
      productImages: imageUrls,
    );
    await productServices.uploadDataToDatabase(productModel);

    clearValues();
  }
}
