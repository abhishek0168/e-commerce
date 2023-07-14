import 'dart:developer';

import 'package:ecommerce_app/model/user_model/user_model.dart';
import 'package:ecommerce_app/services/firebase_user_services.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';

class AddressViewModel extends ChangeNotifier {
  final nameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final houseNameController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final pinCodeController = TextEditingController();
  final countyController = TextEditingController();
  bool isUpdating = false;

  List<UserAddress> userAddresss = [];
  UserAddress? selectedAddress;
  UserModel? userData;

  // instances
  final firebaseUserService = FirebaseUserDetails();

  Future<void> init() async {
    await getUserAddress();
    notifyListeners();
  }

  Future<List<UserAddress>> getUserAddress() async {
    userData = await firebaseUserService.getUserDetails();
    if (userData != null && userData!.userAddress != null) {
      userAddresss = userData!.userAddress!
          .map(
            (data) => UserAddress(
              id: data['id'],
              name: data['name'],
              mobileNumber: data['mobileNumber'],
              city: data['city'],
              houseName: data['houseName'],
              state: data['state'],
              district: data['district'],
              country: data['country'],
              pincode: data['pincode'],
              status: data['status'],
            ),
          )
          .toList();
      log('getUserAddress()=> $userAddresss');
    }
    // notifyListeners();
    return userAddresss;
  }

  clearTextFeild() {
    nameController.clear();
    phoneNoController.clear();
    houseNameController.clear();
    districtController.clear();
    stateController.clear();
    cityController.clear();
    pinCodeController.clear();
    countyController.clear();
  }

  void editAddress(UserAddress data) {
    nameController.text = data.name;
    phoneNoController.text = data.mobileNumber;
    houseNameController.text = data.houseName;
    districtController.text = data.district;
    stateController.text = data.state;
    cityController.text = data.city;
    pinCodeController.text = data.pincode;
    countyController.text = data.country;
    notifyListeners();
  }

  void addUserAddress(BuildContext context) async {
    try {
      loadingIdicator(context);
      final data = UserAddress(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: nameController.text.trim(),
        city: cityController.text.trim(),
        mobileNumber: phoneNoController.text.trim(),
        houseName: houseNameController.text.trim(),
        state: stateController.text.trim(),
        district: districtController.text.trim(),
        country: countyController.text.trim(),
        pincode: pinCodeController.text.trim(),
        status: false,
      );

      userAddresss.add(data);
      final json = userAddresss
          .map((e) => {
                'id': e.id,
                'name': e.name,
                'mobileNumber': e.mobileNumber,
                'city': e.city,
                'houseName': e.houseName,
                'state': e.state,
                'district': e.district,
                'country': e.country,
                'pincode': e.pincode,
                'status': e.status,
              })
          .toList();
      log(json.toString());
      await firebaseUserService.updateUserAddress(json, userData!.id);
      await getUserAddress();
      clearTextFeild();
      notifyListeners();
      if (context.mounted) Navigator.pop(context);
    } catch (e) {
      log('Error from updateUserAddress()=>\n$e');
    }
  }

  void updateUserAddress(String addressId, BuildContext context) async {
    loadingIdicator(context);
    userAddresss.removeWhere((element) => addressId == element.id);
    final data = UserAddress(
      id: addressId,
      name: nameController.text.trim(),
      city: cityController.text.trim(),
      mobileNumber: phoneNoController.text.trim(),
      houseName: houseNameController.text.trim(),
      state: stateController.text.trim(),
      district: districtController.text.trim(),
      country: countyController.text.trim(),
      pincode: pinCodeController.text.trim(),
      status: false,
    );

    userAddresss.add(data);
    final json = userAddresss
        .map((e) => {
              'id': e.id,
              'name': e.name,
              'mobileNumber': e.mobileNumber,
              'city': e.city,
              'houseName': e.houseName,
              'state': e.state,
              'district': e.district,
              'country': e.country,
              'pincode': e.pincode,
              'status': e.status,
            })
        .toList();
    log(json.toString());
    await firebaseUserService.updateUserAddress(json, userData!.id);
    await getUserAddress();
    clearTextFeild();
    notifyListeners();
    if (context.mounted) Navigator.pop(context);
  }

  void updateSelectedAddress(UserAddress addresss, bool status) {
    if (status) {
      selectedAddress = addresss;
    }
    log('${selectedAddress?.name}');
    notifyListeners();
  }
}
