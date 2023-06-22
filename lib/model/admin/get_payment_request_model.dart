class GetPaymentRequestModel {
  bool? success;
  List<Data>? data;

  GetPaymentRequestModel({this.success, this.data});

  GetPaymentRequestModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  SinglePaymentRequest? singlePaymentRequest;
  String? mobileNo;
  String? name;

  Data({this.singlePaymentRequest, this.mobileNo, this.name});

  Data.fromJson(Map<String, dynamic> json) {
    singlePaymentRequest = json['singlePaymentRequest'] != null
        ? new SinglePaymentRequest.fromJson(json['singlePaymentRequest'])
        : null;
    mobileNo = json['mobileNo'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.singlePaymentRequest != null) {
      data['singlePaymentRequest'] = this.singlePaymentRequest!.toJson();
    }
    data['mobileNo'] = this.mobileNo;
    data['name'] = this.name;
    return data;
  }
}

class SinglePaymentRequest {
  String? sId;
  String? userId;
  String? nfcSerialNumber;
  String? paymentMethod;
  int? amount;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SinglePaymentRequest(
      {this.sId,
      this.userId,
      this.nfcSerialNumber,
      this.paymentMethod,
      this.amount,
      this.createdAt,
      this.updatedAt,
      this.iV});

  SinglePaymentRequest.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    nfcSerialNumber = json['nfcSerialNumber'];
    paymentMethod = json['paymentMethod'];
    amount = json['amount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['nfcSerialNumber'] = this.nfcSerialNumber;
    data['paymentMethod'] = this.paymentMethod;
    data['amount'] = this.amount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
