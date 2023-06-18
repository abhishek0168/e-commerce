import 'dart:developer';
import 'dart:io';
import 'package:ecommerce_app/model/product_model/product_model.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view_model/product_data_from_firebase.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum ProductStatus {
  available,
  nuavailable,
}

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
  final productDiscountedprice = TextEditingController(text: '0');

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

  bool isLoading = false;
  bool isUpdate = false;
  ProductStatus? productStatus = ProductStatus.available;

  // instances

  final productServices = FirebaseProductServices();
  final dataFromFirebase = DataFromFirebase();

// functions

  // init fucntion
  void init() async {}

  // product update function
  void updateProduct(ProductModel product) {
    isUpdate = !isUpdate;
    
  }

  // radio button

  void changeStatus(ProductStatus? status) {
    productStatus = status;
    notifyListeners();
  }

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

  // discount price
  void findDiscountPrice() {
    int price = int.parse(productPrice.text);
    int discount = int.parse(productDiscount.text);
    int discountPrice = (price - ((discount / 100) * price)).toInt();
    productDiscountedprice.text = '$discountPrice';
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
    productStock.text = '0';
    productDiscount.text = '0';
    productSizeS.text = '0';
    productSizeM.text = '0';
    productSizeL.text = '0';
    productSizeXL.text = '0';
    productDiscountedprice.text = '0';
    genderDropDownValue = genderItemValues[0];
    categoryDropValue = categories[0];
    productStatus = ProductStatus.available;

    notifyListeners();
  }

  Future<void> changeLoading() async {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> uploadValues() async {
    await changeLoading();
    List<String> imageUrls;

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
      productDiscountedprice: int.parse(productDiscountedprice.text),
      productCategory: categoryDropValue,
      productImages: imageUrls,
      status: productStatus == ProductStatus.available ? true : false,
    );
    await productServices.uploadDataToDatabase(productModel);
    await dataFromFirebase.callPrductDetails();
    clearValues();
    changeLoading();
    notifyListeners();
  }
}
