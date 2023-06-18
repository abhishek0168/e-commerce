import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/user_model/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class UserAuthFirebase {
  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future<String?> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
    } catch (e) {
      return (e.toString());
    }
    return null;
  }

  Future<void> signOut() async {
    DefaultCacheManager().emptyCache();
  }

  Future<void> addUserToDatabase(UserModel model) async {
    final userDoc = FirebaseFirestore.instance.collection('Users').doc();
    final userData = UserModel(
      id: userDoc.id,
      userName: model.userName,
      userEmail: model.userEmail,
      userPassword: model.userPassword,
    );

    final json = userData.toJson();
    await userDoc.set(json);
  }
}
