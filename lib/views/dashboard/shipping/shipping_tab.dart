import 'package:flutter/cupertino.dart';
import 'package:hk_clothes/views/dashboard/shipping/widgets/shippingproduct.dart';

class ShippingTab extends StatelessWidget {
  const ShippingTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(scrollDirection: Axis.vertical,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
      return ShippingProduct(productID: 'productID', productName: 'productName', productPrice: 'productPrice');

    });
  }
}
