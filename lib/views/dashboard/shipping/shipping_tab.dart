import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hk_clothes/views/dashboard/shipping/widgets/shippingcard_widget.dart';

class ShippingTab extends StatelessWidget {
  const ShippingTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color:  Colors.grey.shade200,
      child: ListView.builder(scrollDirection: Axis.vertical,
          itemCount:3,
          itemBuilder: (BuildContext context, int index) {
        return Container(padding: EdgeInsets.symmetric(horizontal: 5),
            child: ShippingProduct());

      }),
    );
  }
}
