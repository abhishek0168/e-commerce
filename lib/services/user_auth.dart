import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/user_model/user_model.dart';
// import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuthFirebase {
  // final userDetailsViewModel = UserDetailsViewModel();
  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // await userDetailsViewModel.fetchingUserData();
      log('signIn function called');
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
      // await userDetailsViewModel.fetchingUserData();
      log('createUser function called');
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
    await FirebaseAuth.instance.signOut();
    // await FirebaseFirestore.instance.clearPersistence();
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

  Future<void> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;
    log('signInWithGoogle() ${googleUser.email}');
    log('signInWithGoogle() ${googleUser.id}');
    log('signInWithGoogle() ${googleUser.displayName}');
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userModel = UserModel(
      id: '',
      userName: googleUser.displayName!,
      userEmail: googleUser.email,
      userPassword: '',
    );

    await addUserToDatabase(userModel);
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<bool> emailVerification() async {
    bool status = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!status) {
      await sendVerificationMail();
    }
    return status;
  }

  Future<void> sendVerificationMail() async {
    final user = FirebaseAuth.instance.currentUser;
    await user!.sendEmailVerification();
  }

  Future<String?> resetUserPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return 'mail-send';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
