import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constant.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      ),
    );
  }
}
