import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hk_clothes/constants/app_color.dart';

class ShippingProduct extends StatelessWidget {
  final String productID;
  final String productName;
  final String productPrice;

  const ShippingProduct(
      {Key key,
      @required this.productID,
      @required this.productName,
      @required this.productPrice})
      : super(key: key);





  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(right: 10),
                width: 85.0,
                height: 75.0,
                decoration: new BoxDecoration(
                    color: AppColors.app.shade400,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image:
                            new AssetImage('assets/images/logo_splash.png')))),
            Expanded(
                child: SizedBox(
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        productID,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffEFC5CD)),
                      ),
                      Text(
                        productName,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        productPrice,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                            ),
                      ),
                    ],
                  ),
                )),
            SpinKitPouringHourglass(color: Colors.black),
          ],
        ),
      ),
    );
  }
}
