import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/models/bag/product_bag.dart';
import 'package:hk_clothes/models/product/product.dart';
import 'package:hk_clothes/models/product/product_detail.dart';
import 'package:shimmer/shimmer.dart';

class ItemOrderProduct extends StatelessWidget {
  final size;
  final ProductBag productBag;
  const ItemOrderProduct({key, this.size, @required this.productBag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<ProductDetail> productDetail = ProductDetail().obs;
    productController.getProductDetail(productBag.pid).then((value) {
      productDetail.value = value;
    });
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
      width: size,
      height: size * 1.25,
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    child: _image,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
