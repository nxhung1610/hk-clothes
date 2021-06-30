import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/views/dashboard/account/widget/editprofile_widget.dart';
import 'package:hk_clothes/views/product/widgets/product_widget.dart';

class WishListTab extends StatelessWidget {
  const WishListTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Obx(
              () => productController.productWishList.length != 0
                  ? GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.66,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemCount: productController.productWishList != null
                          ? productController.productWishList.length
                          : 0,
                      itemBuilder: (context, index) {
                        return ProductItem(
                          size: size.width * (1 / 3),
                          clothes: productController.productWishList[index],
                          function: productController.showInforItem,
                        );
                      },
                    )
                  : Container(),
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
