import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/views/product/widgets/product_widget.dart';

class WishListTab extends StatelessWidget {
  const WishListTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (productController.wishlist.length == 0)
      WidgetsBinding.instance
          .addPostFrameCallback((_) => productController.fetchWishList());

    Size size = MediaQuery.of(context).size;
    return Column(
      children: [],
    );
  }
}
