import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';

import 'widgets/textfield_custom.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.app[200],
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: AppColors.app,
              size: 30,
            )),
      ),
      body: Container(
        color: AppColors.app[200],
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
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

              // Input Password
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: TextFieldCustom(
                  hintText: "Verify Password",
                  typeInput: 1,
                  controllerInput: authController.passwordVerifyController,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: AppColors.app[200],
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () {
                    authController.signUp();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
