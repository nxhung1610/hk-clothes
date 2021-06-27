class ProductBag {
  String pid;
  String sid;
  int number;

  ProductBag({this.pid, this.sid, this.number});

  ProductBag.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    sid = json['size_id'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['number'] = this.number;
    data['size_id'] = this.sid;
    return data;
  }
}
