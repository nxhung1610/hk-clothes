import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/models/shipping_detail.dart';
import 'package:hk_clothes/views/dashboard/shipping/widgets/shippingdetail_widget.dart';

class ShippingProduct extends StatelessWidget {
  const ShippingProduct({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        elevation: 0,
        child: Container(

          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'receiptID',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  )),
                  Text('isShipping',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffEFC5CD))),
                ],
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return ShippingDetailWidget();
                  }),
              Container(

                decoration: BoxDecoration(color:  Colors.grey.shade200, borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Text(
                    'Summary : 2000 VND',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
