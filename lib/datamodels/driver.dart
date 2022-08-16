class Driver {
  Amount? amount;
  bool? approveDriver;
  String? carColor;
  String? carFactory;
  String? carNumber;
  String? carType;
  String? driverCarBackImageUrl;
  String? driverCarFrontImageUrl;
  String? driverCarLicenseImageUrl;
  String? driverLicenseImageUrl;
  bool? driversIsAvailable;
  String? personalImageUrl;
  String? socialAgentNumber;
  String? token;
  String? fullname;
  String? email;
  String? phone;
  String? id;

  Driver(
      {this.amount,
      this.approveDriver,
      this.carColor,
      this.carFactory,
      this.carNumber,
      this.carType,
      this.driverCarBackImageUrl,
      this.driverCarFrontImageUrl,
      this.driverCarLicenseImageUrl,
      this.driverLicenseImageUrl,
      this.driversIsAvailable,
      this.personalImageUrl,
      this.socialAgentNumber,
      this.token,
      this.fullname,
      this.email,
      this.phone,
      this.id});

  Driver.fromJson(Map<String, dynamic> json) {
    amount = json['amount'] != null ? Amount.fromJson(json['amount']) : null;
    approveDriver = json['approveDriver'];
    carColor = json['carColor'];
    carFactory = json['carFactory'];
    carNumber = json['carNumber'];
    carType = json['carType'];
    driverCarBackImageUrl = json['driverCarBackImageUrl'];
    driverCarFrontImageUrl = json['driverCarFrontImageUrl'];
    driverCarLicenseImageUrl = json['driverCarLicenseImageUrl'];
    driverLicenseImageUrl = json['driverLicenseImageUrl'];
    driversIsAvailable = json['driversIsAvailable'];
    personalImageUrl = json['personalImageUrl'];
    socialAgentNumber = json['socialAgentNumber'];
    token = json['token'];
    fullname = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (amount != null) {
      data['amount'] = amount!.toJson();
    }
    data['approveDriver'] = approveDriver;
    data['carColor'] = carColor;
    data['carFactory'] = carFactory;
    data['carNumber'] = carNumber;
    data['carType'] = carType;
    data['driverCarBackImageUrl'] = driverCarBackImageUrl;
    data['driverCarFrontImageUrl'] = driverCarFrontImageUrl;
    data['driverCarLicenseImageUrl'] = driverCarLicenseImageUrl;
    data['driverLicenseImageUrl'] = driverLicenseImageUrl;
    data['driversIsAvailable'] = driversIsAvailable;
    data['personalImageUrl'] = personalImageUrl;
    data['socialAgentNumber'] = socialAgentNumber;
    data['token'] = token;
    data['fullname'] = fullname;
    data['email'] = email;
    data['phone'] = phone;
    data['id'] = id;
    return data;
  }
}

class Amount {
  String? amount;
  String? currentAmount;
  String? status;
  String? transNumber;

  Amount({this.amount, this.currentAmount, this.status, this.transNumber});

  Amount.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currentAmount = json['currentAmount'];
    status = json['status'];
    transNumber = json['transNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['currentAmount'] = currentAmount;
    data['status'] = status;
    data['transNumber'] = transNumber;
    return data;
  }
}
