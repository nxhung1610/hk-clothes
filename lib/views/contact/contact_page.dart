import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Shipping Address",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Container(
          width: 25,
          height: 25,
          padding: EdgeInsets.all(5),
          child: Ink(
            decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0.3),
              shape: CircleBorder(),
            ),
            child: IconButton(
              splashRadius: 25,
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.app[100],
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
      ),
    );
  }
}
