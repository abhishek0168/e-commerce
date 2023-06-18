import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String userName;
  final String userEmail;
  final String userPassword;
  final bool userStatus;
  final List<dynamic>? userFavList;
  final List<dynamic>? userCart;
  final List<dynamic>? userAddress;

  UserModel({
    required this.id,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    this.userFavList,
    this.userCart,
    this.userAddress,
    this.userStatus = true,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'Name': userName,
        'Email': userEmail,
        'Password': userPassword,
        'userFavList': [],
        'userCart': [],
        'userAddress': [],
        'status': userStatus,
      };

  factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return UserModel(
      id: document.id,
      userName: data!['Name'],
      userEmail: data['Email'],
      userPassword: data['Password'],
      userAddress: data['userAddress'],
      userCart: data['userCart'],
      userFavList: data['userFavList'],
      userStatus: data['status'],
    );
  }
}

class UserAddress {
  final String id;
  final String name;
  final String mobileNumber;
  final String houseName;
  final String state;
  final String district;
  final String country;
  final String pincode;

  UserAddress({
    required this.id,
    required this.name,
    required this.mobileNumber,
    required this.houseName,
    required this.state,
    required this.district,
    required this.country,
    required this.pincode,
  });
}
