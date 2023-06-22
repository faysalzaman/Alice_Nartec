class GetProductByUserIdModel {
  bool? success;
  List<Data>? data;

  GetProductByUserIdModel({this.success, this.data});

  GetProductByUserIdModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? userId;
  String? productName;
  String? productItemCode;
  int? gtin;
  String? description;
  String? retailPrice;
  String? offerPrice;
  String? productPhotoIdNo;
  List<String>? images;
  String? productOnSale;
  String? itemUnit;
  String? itemExpiryDate;
  String? itemBatchNo;
  String? itemSerialNumber;
  String? itemAvailableQty;
  String? productStatus;
  int? iV;

  Data(
      {this.sId,
      this.userId,
      this.productName,
      this.productItemCode,
      this.gtin,
      this.description,
      this.retailPrice,
      this.offerPrice,
      this.productPhotoIdNo,
      this.images,
      this.productOnSale,
      this.itemUnit,
      this.itemExpiryDate,
      this.itemBatchNo,
      this.itemSerialNumber,
      this.itemAvailableQty,
      this.productStatus,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    productName = json['productName'];
    productItemCode = json['productItemCode'];
    gtin = json['gtin'];
    description = json['description'];
    retailPrice = json['retailPrice'];
    offerPrice = json['offerPrice'];
    productPhotoIdNo = json['productPhotoIdNo'];
    images = json['images'].cast<String>();
    productOnSale = json['productOnSale'];
    itemUnit = json['itemUnit'];
    itemExpiryDate = json['itemExpiryDate'];
    itemBatchNo = json['itemBatchNo'];
    itemSerialNumber = json['itemSerialNumber'];
    itemAvailableQty = json['itemAvailableQty'];
    productStatus = json['productStatus'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['productName'] = this.productName;
    data['productItemCode'] = this.productItemCode;
    data['gtin'] = this.gtin;
    data['description'] = this.description;
    data['retailPrice'] = this.retailPrice;
    data['offerPrice'] = this.offerPrice;
    data['productPhotoIdNo'] = this.productPhotoIdNo;
    data['images'] = this.images;
    data['productOnSale'] = this.productOnSale;
    data['itemUnit'] = this.itemUnit;
    data['itemExpiryDate'] = this.itemExpiryDate;
    data['itemBatchNo'] = this.itemBatchNo;
    data['itemSerialNumber'] = this.itemSerialNumber;
    data['itemAvailableQty'] = this.itemAvailableQty;
    data['productStatus'] = this.productStatus;
    data['__v'] = this.iV;
    return data;
  }
}
