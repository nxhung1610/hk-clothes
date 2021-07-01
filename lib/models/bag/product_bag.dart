class ProductBag {
  String pid;
  String sid;
  int number;
  double sumPrice;

  ProductBag({this.pid, this.sid, this.number, this.sumPrice});

  ProductBag.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    sid = json['size_id'];
    number = json['number'];
    sumPrice = json['sum_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['number'] = this.number;
    data['size_id'] = this.sid;
    data['sum_price'] = this.sumPrice;
    return data;
  }
}
