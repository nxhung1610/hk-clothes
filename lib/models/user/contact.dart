class Contact {
  String contactId;
  String phoneNumber;
  String address;
  String receiver;

  Contact({this.phoneNumber, this.address, this.receiver, this.contactId});

  Contact.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
    address = json['address'];
    receiver = json['receiver'];
    contactId = json['coontact_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['receiver'] = this.receiver;
    data['contact_id'] = this.contactId;
    return data;
  }
}
