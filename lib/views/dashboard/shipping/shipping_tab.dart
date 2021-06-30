import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/views/dashboard/shipping/widgets/order_ship.dart';

class ShippingTab extends StatelessWidget {
  const ShippingTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.grey[550],
      child: Obx(() {
        var shipping =
            orderController.orders.where((e) => !e.delivered).toList();
        shipping.sort((a, b) => DateTime.parse(b.dateCreate)
            .compareTo(DateTime.parse(a.dateCreate)));
        return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => OrderShip(
                  order: shipping[index],
                ),
            separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
            itemCount: shipping.length);
      }),
    );
  }
}
