import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/models/bag/product_bag.dart';
import 'package:hk_clothes/models/bag/product_bag_menu.dart';
import 'package:hk_clothes/models/product/product.dart';
import 'package:hk_clothes/models/product/product_detail.dart';
import 'package:hk_clothes/models/product/size.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

class ProductbagItem extends StatelessWidget {
  final ProductBag productBag;
  const ProductbagItem({key, this.productBag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tag = Uuid().v1();
    Rx<ProductDetail> productDetail = ProductDetail().obs;
    Rx<SizeProduct> select = SizeProduct().obs;
    productController.getProductDetail(productBag.pid).then((value) {
      productDetail.value = value;
      select.value = productController.sizes
          .where((e) => e.sid == productDetail.value.sizes[0].sid)
          .first;
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
    return Obx(() => productDetail.value.item != null
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            height: 150,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  child: _image,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productDetail.value.item.productName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                color: AppColors.app.shade400,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${productDetail.value.item.price.toInt()} VNĐ",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                color: AppColors.app.shade100,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.app.shade400,
                              ),
                              child: Text(
                                "${select.value.sizeName}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  color: AppColors.app.shade200,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton<MenuItem>(
                        offset: Offset(-10, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onSelected: (value) {},
                        itemBuilder: (context) =>
                            MenuItems.listMenu.map(buillMenuItem).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : ShimmerProductBagItem());
    // return ShimmerProductBagItem();
  }

  PopupMenuEntry<MenuItem> buillMenuItem(MenuItem e) {
    return PopupMenuItem(
      child: Text(
        e.text,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      value: e,
    );
  }
}

class ShimmerProductBagItem extends StatelessWidget {
  const ShimmerProductBagItem({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: AppColors.app[550],
      highlightColor: Colors.grey[100],
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        height: 150,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              width: 100,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    width: size.width * 0.5,
                    height: 20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    width: size.width * 0.3,
                    height: 20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    width: size.width * 0.2,
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
