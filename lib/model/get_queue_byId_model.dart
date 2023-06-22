class GetQueueDataById {
  bool? success;
  String? message;
  List<Data>? data;

  GetQueueDataById({this.success, this.message, this.data});

  GetQueueDataById.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? userId;
  String? userIdAssociateNo;
  String? userNameCaller;
  String? userNameAssociate;
  int? iV;

  Data(
      {this.sId,
      this.userId,
      this.userIdAssociateNo,
      this.userNameCaller,
      this.userNameAssociate,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    userIdAssociateNo = json['userIdAssociateNo'];
    userNameCaller = json['userNameCaller'];
    userNameAssociate = json['userNameAssociate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['userIdAssociateNo'] = this.userIdAssociateNo;
    data['userNameCaller'] = this.userNameCaller;
    data['userNameAssociate'] = this.userNameAssociate;
    data['__v'] = this.iV;
    return data;
  }
}
