import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/views/dashboard/home/widgets/category_widget.dart';
import 'package:hk_clothes/views/product/widgets/product_widget.dart';

class HomeTab extends StatelessWidget {
  final ScrollController _controller = ScrollController();
  _onScroll() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if (homeController.listProductRecommand.length != 0)
        homeController.fetchProductsRecommandNext();
      else
        homeController.fetchProductsRecommand();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (homeController.listProductTrending.length == 0)
      WidgetsBinding.instance
          .addPostFrameCallback((_) => homeController.fetchProductsTrending());

    _controller.addListener(_onScroll);

    return RefreshIndicator(
      onRefresh: () async {
        homeController.refreshDataHomeTab();
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => homeController.fetchProductsTrending());
      },
      child: SingleChildScrollView(
        controller: _controller,
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Center(
                child: Text(
                  "SHOP BY CATEGORY",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            GridView.builder(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.9,
              ),
              itemCount: homeController.listCategory.length,
              itemBuilder: (BuildContext context, int index) {
                return CategoryItem(
                  categoryItem: homeController.listCategory[index]
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Center(
                child: Text(
                  "TRENDING STYLES",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: SizedBox(
                height: size.width * (1 / 2),
                width: double.infinity,
                child: Obx(
                  () => !homeController.isLoadingTrending.value
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeController.listProductTrending != null
                              ? homeController.listProductTrending.length
                              : 0,
                          itemBuilder: (context, index) => ProductItem(
                            size: size.width * (1 / 3),
                            clothes: homeController.listProductTrending[index],
                            function: productController.showInforItem,
                          ),
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 0,
                            );
                          },
                        )
                      : Center(
                          child: SpinKitWave(
                            size: 30,
                            color: AppColors.app[500],
                          ),
                        ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: Text(
                  "RECOMMENDED FOR YOU",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Obx(
              () => homeController.listProductRecommand.length != 0
                  ? Container(
                      child: GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.66,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                        itemCount: homeController.listProductRecommand != null
                            ? homeController.listProductRecommand.length
                            : 0,
                        itemBuilder: (context, index) {
                          // print(homeController.listProductRecommand[index]
                          //     .toJson());
                          return ProductItem(
                            size: size.width * (1 / 3),
                            clothes: homeController.listProductRecommand[index],
                            function: productController.showInforItem,
                          );
                        },
                      ),
                    )
                  : Container(),
            ),
            Obx(
              () => !homeController.isLoadingRecommand.value
                  ? Container()
                  : Center(
                      child: SpinKitWave(
                        size: 30,
                        color: AppColors.app[500],
                      ),
                    ),
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }
}
