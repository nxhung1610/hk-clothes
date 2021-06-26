class Size {
  String sid;
  String sizeName;

  Size({this.sid, this.sizeName});

  Size.fromJson(Map<String, dynamic> json) {
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
