import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  final Function function;
  const ProductbagItem({
    key,
    @required this.productBag,
    @required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tag = Uuid().v1();
    Rx<ProductBag> finalProductBag = productBag.obs;
    Rx<ProductDetail> productDetail = ProductDetail().obs;
    Rx<SizeProduct> select = SizeProduct().obs;
    productController.getProductDetail(finalProductBag.value.pid).then((value) {
      productDetail.value = value;

      select.value = productController.sizes
          .where((e) => e.sid == finalProductBag.value.sid)
          .first;

      // Caculator
      bagController.numberProductBag.value += productBag.number;
      bagController.sumPrice.value +=
          productDetail.value.item.price.toInt() * productBag.number;
      if (productDetail.value.sale != null)
        bagController.discountPrice.value += (productDetail.value.item.price *
                productBag.number *
                (productDetail.value.sale.percent / 100))
            .toInt();
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
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 100,
                    child: GestureDetector(
                      onTap: () => function(productDetail.value.item, tag),
                      child: _image,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.topLeft,
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
                                    "${productDetail.value.sale == null ? productDetail.value.item.price.toInt() : (productDetail.value.item.price.toInt() - (productDetail.value.item.price.toInt() * (productDetail.value.sale.percent / 100))).toInt()} VNĐ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                        color: productDetail.value.sale == null
                                            ? AppColors.app.shade100
                                            : AppColors.app.shade700),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
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
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            splashColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            onPressed: () {
                                              bagController
                                                  .decrNumProduct(productBag);
                                            },
                                            icon: Icon(
                                              FontAwesomeIcons.minus,
                                              color: AppColors.app.shade400,
                                              size: 15,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            finalProductBag.value.number
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          IconButton(
                                            splashColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            onPressed: () {
                                              bagController
                                                  .incrNumProduct(productBag);
                                            },
                                            icon: Icon(
                                              FontAwesomeIcons.plus,
                                              color: AppColors.app.shade400,
                                              size: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          PopupMenuButton<MenuItem>(
                            offset: Offset(-10, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onSelected: (value) {
                              switch (value.value) {
                                case 1:
                                  bagController.delProductBag(productBag);
                              }
                            },
                            itemBuilder: (context) =>
                                MenuItems.listMenu.map(buillMenuItem).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
