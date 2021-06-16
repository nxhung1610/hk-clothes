import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/models/product/product.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = Get.arguments[0];
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Ink(
          decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: CircleBorder(),
          ),
          child: IconButton(
            splashRadius: 28,
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.app[100],
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        actions: [],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: size.width,
              height: size.height * 0.7,
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
