import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/views/product/widgets/product_widget.dart';

class SaleTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (homeController.listProductSale.length == 0)
      homeController.fetchProductsSale();
    return RefreshIndicator(
      onRefresh: () async {
        homeController.refreshDataSaleTab();
        homeController.fetchProductsSale();
      },
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowGlow();
          return;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10),
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Obx(
                () => homeController.listProductSale.length != 0
                    ? Container(
                        child: GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.65,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                          ),
                          itemCount: homeController.listProductSale.length,
                          itemBuilder: (context, index) => ProductItem(
                            size: size.width * (1 / 3),
                            clothes: homeController.listProductSale[index],
                            function: productController.showInforItem,
                          ),
                        ),
                      )
                    : Container(),
              ),
              Obx(
                () => !homeController.isLoadingSale.value
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: SpinKitWave(
                            size: 30,
                            color: AppColors.app[500],
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }
}
