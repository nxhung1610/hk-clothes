class Product {
  String pid;
  String productName;
  String type;
  String imageUrl;
  double price;

  Product({this.pid, this.productName, this.type, this.price});

  Product.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    productName = json['product_name'];
    type = json['type'];
    price = json['price'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['product_name'] = this.productName;
    data['type'] = this.type;
    data['price'] = this.price;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
