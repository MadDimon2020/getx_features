import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final fbUser = FirebaseAuth.instance.authStateChanges();

  bool isLoading = false;
  bool isLoginMode = true;

  void switchAuthMode() {
    isLoginMode = !isLoginMode;
    update();
  }

  void submitAuthForm({String userName, String email, String password}) async {
    UserCredential userCredential;
    try {
      isLoading = true;
      update();
      if (isLoginMode) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        isLoading = false;
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set({
          'username': userName,
          'email': email,
          'userId': userCredential.user.uid,
        });
        isLoading = false;
      }
    } on PlatformException catch (e) {
      var message = 'An error occured, please check your credentials';

      if (e.message != null) {
        message = e.message;
      }
      Get.snackbar(
        'An error occured!',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey[300],
      );
      isLoading = false;
      update();
    } catch (e) {
      Get.snackbar(
        'An error occured!',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey[300],
      );
      isLoading = false;
      update();
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      Get.snackbar(
        'Error Signing Out!',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey[300],
      );
    }
  }
}
