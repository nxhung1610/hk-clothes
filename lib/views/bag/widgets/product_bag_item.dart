import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/models/bag/product_bag.dart';
import 'package:hk_clothes/models/product/product.dart';
import 'package:hk_clothes/models/product/product_detail.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

class ProductbagItem extends StatelessWidget {
  final ProductBag productBag;
  const ProductbagItem({key, this.productBag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tag = Uuid().v1();
    Rx<ProductDetail> productDetail = ProductDetail().obs;
    productController
        .getProductDetail(productBag.pid)
        .then((value) => productDetail.value = value);
    final _image = Obx(
      () => productDetail.value.item != null
          ? CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: productDetail.value.item.imageUrl,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: AppColors.app[550],
                highlightColor: Colors.grey[100],
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              color: AppColors.app[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Shimmer.fromColors(
              baseColor: AppColors.app[550],
              highlightColor: Colors.grey[100],
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            color: AppColors.app[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: 150,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: 100,
            child: _image,
          ),
        ],
      ),
    );
  }
}
