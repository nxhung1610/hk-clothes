import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/assets.dart';
import 'package:hk_clothes/constants/controller.dart';

import 'widgets/textfield_custom.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.app[200],
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.7,
                child: logo,
              ),
              Builder(
                builder: (context) => Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      elevation: 0,
                      side: BorderSide(
                        color: AppColors.app,
                        width: 3,
                      ),
                      primary: AppColors.app[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.app,
                        ),
                      ),
                    ),
                    onPressed: () {
                      _bottomSheetLogin(context);
                    },
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.03,
              ),

              // Button Login
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shadowColor: Colors.white,
                    onPrimary: AppColors.app[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.app[200],
                      ),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed("/register");
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                width: double.infinity,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      _bottomSheetForgotPassword(context);
                    },
                    child: Text(
                      "Forgot your password ?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.app,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _bottomSheetLogin(context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {

    // });
    Get.bottomSheet(
      FormLogin(),
      isScrollControlled: true,
    );
  }

  _bottomSheetForgotPassword(context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {

    // });
    Get.bottomSheet(
      FormForgotPassword(),
      isScrollControlled: true,
    );
  }
}

class FormLogin extends StatelessWidget {
  const FormLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                offset: Offset(0, 5),
                spreadRadius: 3,
                color: Colors.grey.withOpacity(0.5),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45))),
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                margin: EdgeInsets.only(top: 10),
                height: 5,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                    color: AppColors.app.withOpacity(0.7),
                    borderRadius: BorderRadius.all(Radius.circular(10)))),

            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Login Your Account",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Input Email
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: TextFieldCustom(
                hintText: "Email",
                typeInput: 0,
                controllerInput: authController.emailController,
              ),
            ),

            SizedBox(
              height: size.height * 0.03,
            ),

            // Input Password
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: TextFieldCustom(
                hintText: "Password",
                typeInput: 1,
                controllerInput: authController.passwordController,
              ),
            ),

            SizedBox(
              height: size.height * 0.03,
            ),
            // Button Login
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: AppColors.app[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  authController.signIn();
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}

class FormForgotPassword extends StatelessWidget {
  const FormForgotPassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                offset: Offset(0, 5),
                spreadRadius: 3,
                color: Colors.grey.withOpacity(0.5),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45))),
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                margin: EdgeInsets.only(top: 10),
                height: 5,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                    color: AppColors.app.withOpacity(0.7),
                    borderRadius: BorderRadius.all(Radius.circular(10)))),

            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Input Email
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: TextFieldCustom(
                hintText: "Email",
                typeInput: 0,
                controllerInput: authController.emailController,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            // Button Login
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: AppColors.app[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Send Email",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  authController.forgotPassword();
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
