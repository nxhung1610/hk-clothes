import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/firebase.dart';
import 'package:hk_clothes/models/user_infor.dart';
import 'package:hk_clothes/utils/helpers/show_loading.dart';
import 'package:hk_clothes/utils/helpers/show_snackbar.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  UserInfor userInfor;
  TextEditingController emailController,
      passwordController,
      passwordVerifyController;

  Rx<User> firebaseUser;
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Init Controller
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordVerifyController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User>(firebaseAuth.currentUser);
    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User user) async {
    if (user == null) {
      Get.offAllNamed("/login");
    } else {
      await userCheckDatabase(user).then((value) {
        userInfor = value;
        Get.offAllNamed("/home");
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
    // Dispose Controller
    emailController.dispose();
    passwordController.dispose();
  }

  Future signIn() async {
    if (!validatedInputSignIn()) {
      return;
    }
    showLoading();
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      dismissLoadingWidget();
      showSnackbar("Sign Up Failed", "Email or Password not valid", false);
    }

    Get.offAllNamed("/home");
  }

  Future signUp() async {
    if (!validatedInputSignUp()) {
      return;
    }
    showLoading();

    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      dismissLoadingWidget();
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        showSnackbar(
            "Sign Up Failed", "The password provided is too weak.", false);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        showSnackbar("Sign Up Failed",
            "The account already exists for that email.", false);
      }
    } catch (e) {
      print(e);
    }
  }

  bool validatedInputSignUp() {
    if (passwordController.text.trim().isEmpty ||
        passwordVerifyController.text.trim().isEmpty ||
        !emailController.text.trim().isEmail) {
      showSnackbar("Sign Up Failed", "Input not valid", false);
      return false;
    }
    if (passwordController.text != passwordVerifyController.text) {
      showSnackbar("Sign Up Failed", "Password not equal", false);
      return false;
    }
    return true;
  }

  bool validatedInputSignIn() {
    if (passwordController.text.trim().isEmpty ||
        !emailController.text.trim().isEmail) {
      showSnackbar("Login Failed", "Input not valid", false);
      return false;
    }
    return true;
  }

  Future<UserInfor> userCheckDatabase(User user) async {
    var k = await firestore.collection("users").doc(user.uid).get();
    if (k.exists) {
      return UserInfor.fromJson(k.data());
    } else {
      var k = UserInfor(
        uid: user.uid,
        lastName: "",
        firstName: "",
        nickname: (Random().nextInt(799999) + 100000).toString(),
        email: user.email,
        birthday: "",
        gender: "male",
        photoUrl: "",
      );
      await firestore.collection("users").doc(k.uid).set(k.toJson());
      return k;
    }
  }
}
