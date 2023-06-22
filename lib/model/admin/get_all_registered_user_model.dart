class GetAllRegisteredUserModel {
  String? userPicture;
  String? sId;
  String? userId;
  String? userLoginId;
  String? userPassword;
  String? fullName;
  String? emailId;
  String? mobileNo;
  String? userTypeIdNo;
  bool? adminAccess;
  String? userStatus;
  int? iV;

  GetAllRegisteredUserModel(
      {this.userPicture,
      this.sId,
      this.userId,
      this.userLoginId,
      this.userPassword,
      this.fullName,
      this.emailId,
      this.mobileNo,
      this.userTypeIdNo,
      this.adminAccess,
      this.userStatus,
      this.iV});

  GetAllRegisteredUserModel.fromJson(Map<String, dynamic> json) {
    userPicture = json['userPicture'];
    sId = json['_id'];
    userId = json['userId'];
    userLoginId = json['userLoginId'];
    userPassword = json['userPassword'];
    fullName = json['fullName'];
    emailId = json['emailId'];
    mobileNo = json['mobileNo'];
    userTypeIdNo = json['userTypeIdNo'];
    adminAccess = json['adminAccess'];
    userStatus = json['userStatus'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userPicture'] = this.userPicture;
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['userLoginId'] = this.userLoginId;
    data['userPassword'] = this.userPassword;
    data['fullName'] = this.fullName;
    data['emailId'] = this.emailId;
    data['mobileNo'] = this.mobileNo;
    data['userTypeIdNo'] = this.userTypeIdNo;
    data['adminAccess'] = this.adminAccess;
    data['userStatus'] = this.userStatus;
    data['__v'] = this.iV;
    return data;
  }
}
