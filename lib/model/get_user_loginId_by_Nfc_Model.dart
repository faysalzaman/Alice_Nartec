class GetUserLoginIdByNfcModel {
  bool? success;
  String? message;
  User? user;
  List<Wallet>? wallet;

  GetUserLoginIdByNfcModel(
      {this.success, this.message, this.user, this.wallet});

  GetUserLoginIdByNfcModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['wallet'] != null) {
      wallet = <Wallet>[];
      json['wallet'].forEach((v) {
        wallet!.add(new Wallet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.wallet != null) {
      data['wallet'] = this.wallet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? sId;
  String? userId;
  String? userLoginId;
  String? userPassword;
  String? fullName;
  String? emailId;
  String? mobileNo;
  String? userTypeIdNo;
  bool? adminAccess;
  String? userPicture;
  String? userStatus;
  int? iV;

  User(
      {this.sId,
      this.userId,
      this.userLoginId,
      this.userPassword,
      this.fullName,
      this.emailId,
      this.mobileNo,
      this.userTypeIdNo,
      this.adminAccess,
      this.userPicture,
      this.userStatus,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    userLoginId = json['userLoginId'];
    userPassword = json['userPassword'];
    fullName = json['fullName'];
    emailId = json['emailId'];
    mobileNo = json['mobileNo'];
    userTypeIdNo = json['userTypeIdNo'];
    adminAccess = json['adminAccess'];
    userPicture = json['userPicture'];
    userStatus = json['userStatus'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['userLoginId'] = this.userLoginId;
    data['userPassword'] = this.userPassword;
    data['fullName'] = this.fullName;
    data['emailId'] = this.emailId;
    data['mobileNo'] = this.mobileNo;
    data['userTypeIdNo'] = this.userTypeIdNo;
    data['adminAccess'] = this.adminAccess;
    data['userPicture'] = this.userPicture;
    data['userStatus'] = this.userStatus;
    data['__v'] = this.iV;
    return data;
  }
}

class Wallet {
  String? sId;
  String? userId;
  String? nfcSerialNumber;
  String? nfcCardType;
  String? nfcDetails;
  int? cardAvailableAmount;
  int? iV;

  Wallet(
      {this.sId,
      this.userId,
      this.nfcSerialNumber,
      this.nfcCardType,
      this.nfcDetails,
      this.cardAvailableAmount,
      this.iV});

  Wallet.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    nfcSerialNumber = json['nfcSerialNumber'];
    nfcCardType = json['nfcCardType'];
    nfcDetails = json['nfcDetails'];
    cardAvailableAmount = json['cardAvailableAmount'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['nfcSerialNumber'] = this.nfcSerialNumber;
    data['nfcCardType'] = this.nfcCardType;
    data['nfcDetails'] = this.nfcDetails;
    data['cardAvailableAmount'] = this.cardAvailableAmount;
    data['__v'] = this.iV;
    return data;
  }
}
