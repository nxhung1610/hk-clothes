import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/ViewModels/auth/login_controller.dart';
import 'package:hk_clothes/views/widgets/textfield_custom.dart';

import '../../../constant.dart';

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
          height: size.height,
          width: size.width,
          child: Stack(
            fit: StackFit.expand,
            children: [
              FittedBox(
                fit: BoxFit.fill,
                child: Image.asset(
                  "assets/images/login/background.jpg",
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: size.width * 0.3,
                          height: size.width * 0.3,
                          child: Card(
                            elevation: 20,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/images/logo.svg",
                                width: size.width * 0.23,
                                color: AppColors.app,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          child: Text(
                            "Hyber King",
                            style: TextStyle(
                              fontSize: 40,
                              color: AppColors.app[200],
                              fontFamily: 'Boldywolf',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.3,
                        ),
                        Builder(
                          builder: (context) => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.1),
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                onPrimary: AppColors.app,
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
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.app,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                _bottomSheet(context);
                              },
                            ),
                          ),
                        ),

                        SizedBox(
                          height: size.height * 0.03,
                        ),

                        // Button Login
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              onPrimary: AppColors.app[200],
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: AppColors.app[200],
                                  width: 3,
                                ),
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Get.toNamed("/register");
                            },
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                      ],
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

  _bottomSheet(context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => FormLogin(),
      );
    });
  }
}

class FormLogin extends StatelessWidget {
  const FormLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
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
          child: Form(
            key: loginController.loginFormKey,
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
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.app,
                    ),
                  ),
                ),
                // Input Email
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: TextFieldCustom(
                    hintText: "Email",
                    typeInput: 0,
                    controllerInput: loginController.emailController,
                    validate: loginController.validateEmail,
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
                    controllerInput: loginController.passwordController,
                    validate: loginController.validatePassword,
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
                        "Login",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () {
                      loginController.checkLogin();
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
