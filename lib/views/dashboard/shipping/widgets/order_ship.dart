import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/models/order/order.dart';
import 'package:hk_clothes/models/order/order_shhip_menu.dart';
import 'package:hk_clothes/views/dashboard/shipping/widgets/product_item_ship.dart';
import 'package:intl/intl.dart';

class OrderShip extends StatelessWidget {
  final Order order;
  const OrderShip({key, @required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 0.2,
            blurRadius: 1,
            color: AppColors.app.shade400.withOpacity(0.1),
          )
        ],
        color: AppColors.app[200],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '#${order.orderId}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.app.shade400,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(
                Icons.local_shipping_rounded,
                color: Colors.amber,
              ),
              !order.delivered
                  ? PopupMenuButton<OrderMenuItem>(
                      offset: Offset(-10,
                          size.height * 0.04 > 30 ? 30 : size.height * 0.04),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onSelected: (value) {
                        switch (value.value) {
                          case 1:
                            break;
                          case 2:
                            break;
                        }
                      },
                      itemBuilder: (context) =>
                          OrderMenuItems.listMenu.map(buillMenuItem).toList(),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Order : ${DateFormat('dd/MM/yyyy').format(DateTime.parse(order.dateCreate))}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.app,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Complete : ${order.dateDone != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(order.dateDone)) : '___'}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.greenAccent[400],
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: order.products.length,
            itemBuilder: (context, index) => ProductShipItem(
              productBag: order.products[index],
              function: productController.showInforItem,
            ),
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 8,
            ),
          ),
          Text(
            'Total Price : ${order.totalPrice.toInt()} VND',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: AppColors.app,
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuEntry<OrderMenuItem> buillMenuItem(OrderMenuItem e) {
    return PopupMenuItem(
      child: Text(
        e.text,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      value: e,
    );
  }
}
