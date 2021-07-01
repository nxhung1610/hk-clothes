import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/models/order/order.dart';
import 'package:hk_clothes/utils/helpers/show_loading.dart';
import 'package:hk_clothes/utils/helpers/show_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'PaypalServices.dart';

class PaypalPayment extends StatefulWidget {
  final Function onFinish;
  final Order order;

  PaypalPayment({this.onFinish, this.order});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String checkoutUrl;
  String executeUrl;
  String accessToken;
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = true;
  bool isEnableAddress = true;

  String returnURL = 'https://www.facebook.com/nxhung.hit/';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();

        final transactions = getOrderParams();
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }
      } catch (e) {
        print('exception: ' + e.toString());

        showActionSnackBar(context, e.toString());
      }
    });
  }

  // item name, price and quantity

  Map<String, dynamic> getOrderParams() {
    List items = [
      {
        "name": widget.order.orderId,
        "quantity": 1,
        "price": (widget.order.totalPrice / 23016.00).toStringAsFixed(2),
        "currency": defaultCurrency["currency"]
      }
    ];

    // checkout invoice details
    String totalAmount =
        (widget.order.totalPrice / 23016.00).toStringAsFixed(2);
    String subTotalAmount =
        (widget.order.totalPrice / 23016.00).toStringAsFixed(2);
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String userFirstName = widget.order.contact.receiver.split(" ")[0];
    String userLastName = widget.order.contact.receiver.split(" ")[1];
    String addressCity = 'VietNam';
    String addressStreet = widget.order.contact.address;
    String addressZipCode = '700000';
    String addressCountry = 'VN';
    String addressState = 'VietNam';
    String addressPhoneNumber = widget.order.contact.phoneNumber;

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            if (isEnableShipping && isEnableAddress)
              "shipping_address": {
                "recipient_name": userFirstName + " " + userLastName,
                "line1": addressStreet,
                "line2": "",
                "city": addressCity,
                "country_code": addressCountry,
                "postal_code": addressZipCode,
                "phone": addressPhoneNumber,
                "state": addressState
              },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    print(checkoutUrl);

    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Paypal Payment'),
          centerTitle: true,
          backgroundColor: AppColors.app,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              showLoading();
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services
                    .executePayment(executeUrl, payerID, accessToken)
                    .then((id) {
                  widget.onFinish(id);
                  Get.back();
                });
              } else {
                widget.onFinish(null);
                Get.back();
              }
              Get.back();
            }
            if (request.url.contains(cancelURL)) {
              Get.back();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Get.back();
              }),
          backgroundColor: AppColors.app,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}
