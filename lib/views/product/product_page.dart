import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/controller.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = productController.product;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
    );
  }
}
