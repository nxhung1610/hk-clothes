class SizeProduct {
  String sid;
  String sizeName;

  SizeProduct({this.sid, this.sizeName});

  SizeProduct.fromJson(Map<String, dynamic> json) {
    sid = json['size_id'];
    sizeName = json['size_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size_id'] = this.sid;
    data['size_name'] = this.sizeName;
    return data;
  }
}
