class UpdateUserByIdModel {
  String? sId;
  String? userId;
  String? userLoginId;
  String? userPassword;
  String? fullName;
  String? emailId;
  String? mobileNo;
  String? userTypeIdNo;
  bool? adminAccess;
  int? iV;
  String? userPicture;

  UpdateUserByIdModel(
      {this.sId,
      this.userId,
      this.userLoginId,
      this.userPassword,
      this.fullName,
      this.emailId,
      this.mobileNo,
      this.userTypeIdNo,
      this.adminAccess,
      this.iV,
      this.userPicture});

  UpdateUserByIdModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    userLoginId = json['userLoginId'];
    userPassword = json['userPassword'];
    fullName = json['fullName'];
    emailId = json['emailId'];
    mobileNo = json['mobileNo'];
    userTypeIdNo = json['userTypeIdNo'];
    adminAccess = json['adminAccess'];
    iV = json['__v'];
    userPicture = json['userPicture'];
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
    data['__v'] = this.iV;
    data['userPicture'] = this.userPicture;
    return data;
  }
}
