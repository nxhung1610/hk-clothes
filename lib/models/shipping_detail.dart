class ShippingDetail {
  int shippingID;
  String uid;
  int sum;
  bool status;
  List<int> pid;

  ShippingDetail({this.shippingID, this.uid, this.sum, this.status, this.pid});

  ShippingDetail.fromJson(Map<String, dynamic> json) {
    shippingID = json['productID'];
    uid = json['UID'];
    sum = json['Sum'];
    status = json['Status'];
    pid = json['PID'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productID'] = this.shippingID;
    data['UID'] = this.uid;
    data['Sum'] = this.sum;
    data['Status'] = this.status;
    data['PID'] = this.pid;
    return data;
  }
}