import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/assets.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/models/product/product.dart';
import 'package:hk_clothes/models/product/product_sale.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

class ProductItem extends StatelessWidget {
  final size;
  final Product clothes;
  final Function function;
  const ProductItem(
      {Key key,
      @required this.size,
      @required this.clothes,
      @required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tag = Uuid().v1();
    final _image = CachedNetworkImage(
      fit: BoxFit.fill,
      imageUrl: clothes.imageUrl,
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
    );
    Rx<ProductSale> productSale = ProductSale().obs;
    Rx<bool> isLoaded = false.obs;
    productController.getSaleProduct(clothes.pid).then((value) {
      productSale.value = value;
      isLoaded.value = true;
    });
    return Obx(
      () => isLoaded.value
          ? Container(
              width: size,
              height: size * 1.25,
              child: Card(
                color: Colors.transparent,
                elevation: 0,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              child: Hero(tag: tag, child: _image),
                            ),
                          ),
                          SizedBox(
                            height: size * 0.05,
                          ),
                          Text(
                            "${productSale.value == null ? clothes.price.toInt() : (clothes.price - (clothes.price * (productSale.value.percent / 100))).toInt()} VND",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: productSale.value == null
                                    ? AppColors.app
                                    : AppColors.app.shade700),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: AppColors.app[500].withOpacity(0.2),
                          splashFactory: InkRipple.splashFactory,
                          onTap: () => function(clothes, tag),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ShimmerProduct(
              size: size,
            ),
    );
  }
}

class ShimmerProduct extends StatelessWidget {
  final size;
  const ShimmerProduct({key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.app[550],
      highlightColor: Colors.grey[100],
      child: Container(
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
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: size * 0.05,
                  ),
                  Container(
                    color: Colors.white,
                    height: 20,
                    width: size * 0.4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
