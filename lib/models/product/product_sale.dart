class ProductSale {
  String saleId;
  String pid;
  double percent;

  ProductSale({this.saleId, this.pid, this.percent});

  ProductSale.fromJson(Map<String, dynamic> json) {
    saleId = json['sale_id'];
    pid = json['pid'];
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_id'] = this.saleId;
    data['pid'] = this.pid;
    data['percent'] = this.percent;
    return data;
  }
}
