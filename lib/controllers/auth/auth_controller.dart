import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/firebase.dart';
import 'package:hk_clothes/utils/helpers/show_loading.dart';
import 'package:hk_clothes/utils/helpers/show_snackbar.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
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
    if (!validatedInputSignIn()) {
      showSnackbar("Login Failed", "Input not valid", false);
      return;
    }
    showLoading();
    await Future.delayed(Duration(seconds: 5));
    Get.offAllNamed("/home");
  }

  Future signUp() async {
    if (!validatedInputSignUp()) {
      showSnackbar("Sign Up Failed", "Input not valid", false);
      return;
    }
    showLoading();

    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

    } on FirebaseAuthException catch (e) {

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    dismissLoadingWidget();

  }

  bool validatedInputSignUp() {
    if (passwordController.text.trim().isEmpty ||
        passwordVerifyController.text.trim().isEmpty ||
        !emailController.text.trim().isEmail) {
      return false;
    }
    if (passwordController.text != passwordVerifyController.text) {
      return false;
    }
    return true;
  }

  bool validatedInputSignIn() {
    if (passwordController.text.trim().isEmpty ||
        !emailController.text.trim().isEmail) {
      return false;
    }
    return true;
  }
}
