import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final containerFromKey = GlobalKey();
  TextEditingController emailController, passwordController;
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
  }

  @override
  void onClose() {
    super.onClose();
    // Dispose Controller
    emailController.dispose();
    passwordController.dispose();
  }

  String validateEmail(String value) {
    return GetUtils.isEmail(value) ? null : "Enter valid Email";
  }

  String validatePassword(String value) {
    value = value.trim();
    var result;
    if (value.length == 0) {
      result = "Please enter your Password";
    }
    return result;
  }

  void checkLogin() {
    final isValid = loginFormKey.currentState.validate();
    if (!isValid) {
      return;
    }
    loginFormKey.currentState.save();
  }
}
