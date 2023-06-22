class GetAllAssociateByUserIdModel {
  Associate? associate;
  User? user;

  GetAllAssociateByUserIdModel({this.associate, this.user});

  GetAllAssociateByUserIdModel.fromJson(Map<String, dynamic> json) {
    associate = json['associate'] != null
        ? new Associate.fromJson(json['associate'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.associate != null) {
      data['associate'] = this.associate!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Associate {
  String? sId;
  String? userId;
  String? userIdAssociateNo;
  String? userNameCaller;
  String? dateTimeCalle;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Associate(
      {this.sId,
      this.userId,
      this.userIdAssociateNo,
      this.userNameCaller,
      this.dateTimeCalle,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Associate.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    userIdAssociateNo = json['userIdAssociateNo'];
    userNameCaller = json['userNameCaller'];
    dateTimeCalle = json['dateTimeCalle'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['userIdAssociateNo'] = this.userIdAssociateNo;
    data['userNameCaller'] = this.userNameCaller;
    data['dateTimeCalle'] = this.dateTimeCalle;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
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
  int? iV;
  String? userPicture;

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
      this.iV,
      this.userPicture});

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
