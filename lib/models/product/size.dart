class Size {
  String sid;
  String sizeName;

  Size({this.sid, this.sizeName});

  Size.fromJson(Map<String, dynamic> json) {
    sid = json['sid'];
    sizeName = json['size_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sid'] = this.sid;
    data['size_name'] = this.sizeName;
    return data;
  }
}
