import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserDetails {
  final _db = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<List<UserModel>> getAllUsers() async {
    final users = await _db.collection('Users').get();
    final userList = users.docs.map((e) => UserModel.fromJson(e)).toList();
    return userList;
  }

  Future<UserModel?> getUserDetails() async {
    final user = _firebaseAuth.currentUser;
    log('${user?.email} getUserDetails()');
    log('${user?.uid}  getUserDetails()');
    try {
      if (user != null) {
        final snapshot = await _db
            .collection('Users')
            .where('Email', isEqualTo: user.email)
            .get();

        final userData = UserModel.fromJson(snapshot.docs.first);
        // final userData = snapshot.docs.map((e) => UserModel.fromJson(e)).single;
        log(userData.userName);
        return userData;
      } else {
        log('user is null getUserDetails()');
      }
    } catch (e) {
      log('$e getUserDetails()=>');
    }

    return null;
  }

  Future<void> updateUserAddress(
      List<Map<dynamic, dynamic>> userAddressList, String userId) async {
    log('$userId userID updateUserCart()=>');
    final docUser = _db.collection('Users').doc(userId);
    Map<String, dynamic> updateJson = {
      'userAddress': userAddressList,
    };
    await docUser.update(updateJson).then((value) {
      log('user address updated');
    });
  }

  Future<void> updateUserCart(
    List<Map<dynamic, dynamic>> productList,
    String userId,
  ) async {
    try {
      log('$userId userID updateUserCart()=>');
      final docUser = _db.collection('Users').doc(userId);

      Map<String, dynamic> updateJson = {
        'userCart': productList,
      };
      await docUser.update(updateJson).then((value) {
        log('Cart updated');
      });
    } catch (e) {
      log('$e updateUserCart()=>');
    }
  }

  Future<void> updateUserOrder(
    List<Map<dynamic, dynamic>> orderList,
    String userId,
  ) async {
    try {
      log('$userId userID updateUserCart()=>');
      final docUser = _db.collection('Users').doc(userId);

      Map<String, dynamic> updateJson = {
        'userOrders': orderList,
      };
      // log('Order list $orderList');
      await docUser.update(updateJson).then((value) {
        log('Order list updated');
      });
    } catch (e) {
      log('updateUserOrder()=> $e');
    }
  }

  Future<void> updateUserFav(
    List<String> productList,
    String userId,
  ) async {
    try {
      final docUser = _db.collection('Users').doc(userId);
      Map<String, dynamic> updateJson = {
        'userFavList': productList,
      };
      await docUser.update(updateJson).then(
            (value) => log('User FavList updated'),
          );
    } catch (e) {
      log('$e updateUserFav()=>');
    }
  }

  Future<void> changeUserStatus(bool status, String userId) async {
    final docUser = _db.collection('Users').doc(userId);
    Map<String, dynamic> updateJson = {
      'status': status,
    };
    await docUser
        .update(updateJson)
        .then((value) => log('changeUserStatus()=> User status changed'));
  }
}
