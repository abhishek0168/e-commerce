import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserDetails {
  final _db = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel?> getUserDetails() async {
    final user = _firebaseAuth.currentUser;
    log('${user?.email} getUserDetails()');
    log('${user?.uid} getUserDetails()');
    try {
      if (user != null) {
        final snapshot = await _db
            .collection('Users')
            .where('Email', isEqualTo: user.email)
            .get();

        final userData = snapshot.docs.map((e) => UserModel.fromJson(e)).single;
        return userData;
      } else {
        log('user is null getUserDetails()');
      }
    } catch (e) {
      log('$e getUserDetails()=>');
    }

    return null;
  }

  Future<void> updateUserCart(
    List<String> productList,
    String userId,
  ) async {
    try {
      log('$userId userID updateUserCart()=>');
      final docUser = _db.collection('Users').doc(userId);
      Map<String, dynamic> updateJson = {
        'userCart': productList,
      };
      docUser.update(updateJson).then((value) {
        log('Cart updated');
      });
    } catch (e) {
      log('$e updateUserCart()=>');
    }
  }

  void updateUserFav(
    List<String> productList,
    String userId,
  ) {
    try {
      final docUser = _db.collection('Users').doc(userId);
      Map<String, dynamic> updateJson = {
        'userFavList': productList,
      };
      docUser.update(updateJson).then(
            (value) => log('User FavList updated'),
          );
    } catch (e) {
      log('$e updateUserCart()=>');
    }
  }
}
