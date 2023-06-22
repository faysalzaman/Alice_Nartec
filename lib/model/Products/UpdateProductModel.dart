class UpdateProductModel {
  bool? success;
  String? message;
  Data? data;

  UpdateProductModel({this.success, this.message, this.data});

  UpdateProductModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? userId;
  String? productName;
  String? productItemCode;
  int? gtin;
  String? description;
  int? retailPrice;
  String? offerPrice;
  String? productPhotoIdNo;
  List<Images>? images;
  String? productOnSale;
  String? itemBatchNo;
  String? itemSerialNumber;
  int? itemAvailableQty;
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
      this.itemBatchNo,
      this.itemSerialNumber,
      this.itemAvailableQty,
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
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    productOnSale = json['productOnSale'];
    itemBatchNo = json['itemBatchNo'];
    itemSerialNumber = json['itemSerialNumber'];
    itemAvailableQty = json['itemAvailableQty'];
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
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['productOnSale'] = this.productOnSale;
    data['itemBatchNo'] = this.itemBatchNo;
    data['itemSerialNumber'] = this.itemSerialNumber;
    data['itemAvailableQty'] = this.itemAvailableQty;
    data['__v'] = this.iV;
    return data;
  }
}

class Images {
  String? sId;
  String? userId;
  String? name;
  String? imagePath;
  String? originalName;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Images(
      {this.sId,
      this.userId,
      this.name,
      this.imagePath,
      this.originalName,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Images.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    name = json['name'];
    imagePath = json['imagePath'];
    originalName = json['originalName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['imagePath'] = this.imagePath;
    data['originalName'] = this.originalName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
