import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/models/bag/product_bag.dart';
import 'package:hk_clothes/models/product/product.dart';
import 'package:hk_clothes/models/product/product_detail.dart';
import 'package:hk_clothes/models/product/size.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Get.arguments[0];
    final tag = Get.arguments[1];
    final size = MediaQuery.of(context).size;
    RxDouble opacity = 0.0.obs;
    _onScroll() {
      if (productController.controller.value.offset < size.height * 0.4) {
        opacity.value =
            (productController.controller.value.offset / (size.height * 0.4));
      } else
        opacity.value = 1.0;
    }

    productController.controller.value.addListener(_onScroll);
    Rx<SizeProduct> select = SizeProduct().obs;
    Rx<ProductDetail> productDetail = ProductDetail().obs;
    productController.getProductDetail(product.pid).then((value) {
      productDetail.value = value;
      select.value = productController.sizes
          .where((e) => e.sid == productDetail.value.sizes.first.sid)
          .first;
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.075),
        child: Obx(
          () => AppBar(
            elevation: 0,
            backgroundColor: Colors.white.withOpacity(opacity.value),
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
            actions: [
              Container(
                child: Ink(
                  decoration: ShapeDecoration(
                    color: Colors.white.withOpacity(0.4),
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    splashRadius: 25,
                    icon: Badge(
                      badgeContent: Obx(
                        () => Text(
                          '${bagController.numberProductBag.value}',
                          style: TextStyle(
                            color: AppColors.app.shade200,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      child: Icon(
                        Icons.shopping_bag,
                        color: AppColors.app[400],
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed("/bag");
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: SingleChildScrollView(
              controller: productController.controller.value,
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                color: AppColors.app[550],
                width: size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.7,
                      child: Hero(
                        tag: tag,
                        child: CachedNetworkImage(
                          imageUrl: product.imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      color: AppColors.app[600],
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${product.price.toInt()} VND',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              product.productName,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      padding: EdgeInsets.all(20),
                      color: AppColors.app.shade600,
                      margin: EdgeInsets.only(top: 5),
                      child: Obx(
                        () => Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Size : ${select.value.sizeName}",
                              style: TextStyle(
                                fontSize: 20,
                                color: AppColors.app.shade500,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: SizedBox(
                                height: 25,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: productDetail.value.sizes == null
                                      ? 0
                                      : productDetail.value.sizes.length,
                                  itemBuilder: (context, index) {
                                    SizeProduct sizeItem = productController
                                        .sizes
                                        .where((e) =>
                                            e.sid ==
                                            productDetail
                                                .value.sizes[index].sid)
                                        .first;

                                    return Obx(() => GestureDetector(
                                          onTap: () => select.value = sizeItem,
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.width * 0.04),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: sizeItem.sid ==
                                                        select.value.sid
                                                    ? AppColors.app
                                                    : AppColors.app.shade500,
                                                width: sizeItem.sid ==
                                                        select.value.sid
                                                    ? 2.5
                                                    : 1,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                sizeItem.sizeName.toString(),
                                                style: TextStyle(
                                                  fontWeight: sizeItem.sid ==
                                                          select.value.sid
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      padding: EdgeInsets.all(20),
                      color: AppColors.app.shade600,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Product Description",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.app,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              product.description
                                  .replaceAll("\\n ", '\n')
                                  .replaceAll("\\n", '\n'),
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.app.shade200,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            width: size.width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.app,
              ),
              onPressed: () {
                bagController.addProductBag(ProductBag(
                    pid: product.pid, number: 1, sid: select.value.sid));
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "ADD TO BAG",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
