class UserData {
  String? fullname;
  String? email;
  String? phone;
  dynamic id;

  UserData({this.fullname, this.email, this.phone, this.id});

  UserData.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullname'] = fullname;
    data['email'] = email;
    data['phone'] = phone;
    data['id'] = id;
    return data;
  }
}
