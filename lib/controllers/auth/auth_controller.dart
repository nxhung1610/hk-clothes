import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/firebase.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  TextEditingController emailController, passwordController;

  Rx<User> firebaseUser;
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Init Controller
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User>(firebaseAuth.currentUser);
    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User user) {
    if (user == null) {
      Get.offAllNamed("/login");
    } else {
      // userModel.bindStream(listenToUser());
      Get.offAllNamed("/home");
    }
  }

  @override
  void onClose() {
    super.onClose();
    // Dispose Controller
    emailController.dispose();
    passwordController.dispose();
  }

  void signIn() async {
    Get.offAllNamed("/home");
  }

  void signUp() async {}
}
