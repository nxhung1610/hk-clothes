import 'package:hk_clothes/models/bag/product_bag.dart';

class Bag {
  List<ProductBag> productBags;

  Bag({this.productBags});

  Bag.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      productBags = [];
      json['products'].forEach((v) {
        productBags.add(ProductBag.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productBags != null) {
      data['products'] = this.productBags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
