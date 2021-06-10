import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackbar(title, message, valid) {
  Get.snackbar(
    title,
    message,
    borderRadius: 10,
    backgroundColor: Colors.white,
    duration: Duration(seconds: 1),
    icon: valid
        ? Icon(
            Icons.check_circle,
            color: Colors.green,
          )
        : Icon(
            Icons.error_outlined,
            color: Colors.yellow,
          ),
    onTap: (snack) {
      Get.back();
    },
    boxShadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        spreadRadius: 1,
        blurRadius: 5,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  );
}
