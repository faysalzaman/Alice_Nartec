class PostProductModel {
  bool? success;
  String? message;
  Data? data;

  PostProductModel({this.success, this.message, this.data});

  PostProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? productName;
  String? productItemCode;
  String? gtin;
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
  String? sId;
  int? iV;

  Data(
      {this.userId,
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
      this.sId,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
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
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}
