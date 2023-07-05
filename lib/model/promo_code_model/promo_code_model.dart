import 'package:cloud_firestore/cloud_firestore.dart';

class PromoCodeModel {
  final String id;
  final String createdDate;
  final String expiryDate;
  final String promoCode;
  final bool status;
  final int discount;
  final List<dynamic> usedUsers;

  PromoCodeModel({
    required this.id,
    required this.createdDate,
    required this.expiryDate,
    required this.promoCode,
    required this.status,
    required this.discount,
    required this.usedUsers,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdDate': createdDate,
      'expiryDate': expiryDate,
      'promoCode': promoCode,
      'discount': discount,
      'status': status,
      'usedUsers' : [],
    };
  }

  factory PromoCodeModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return PromoCodeModel(
      id: document.id,
      createdDate: data!['createdDate'],
      expiryDate: data['expiryDate'],
      promoCode: data['promoCode'],
      status: data['status'],
      discount: data['discount'],
      usedUsers: data['usedUsers'],
    );
  }
}
