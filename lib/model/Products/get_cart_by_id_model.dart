class GetCartByIdModel {
  bool? success;
  List<Data>? data;

  GetCartByIdModel({this.success, this.data});

  GetCartByIdModel.fromJson(Map<String, dynamic> json) {
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
  ProductId? productId;
  String? productDescription;
  String? totalQty;
  String? itemPrice;
  String? couponAmount;
  String? couponIdNo;
  int? iV;

  Data(
      {this.sId,
      this.userId,
      this.productId,
      this.productDescription,
      this.totalQty,
      this.itemPrice,
      this.couponAmount,
      this.couponIdNo,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    productId = json['productId'] != null
        ? new ProductId.fromJson(json['productId'])
        : null;
    productDescription = json['productDescription'];
    totalQty = json['totalQty'];
    itemPrice = json['itemPrice'];
    couponAmount = json['couponAmount'];
    couponIdNo = json['couponIdNo'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    if (this.productId != null) {
      data['productId'] = this.productId!.toJson();
    }
    data['productDescription'] = this.productDescription;
    data['totalQty'] = this.totalQty;
    data['itemPrice'] = this.itemPrice;
    data['couponAmount'] = this.couponAmount;
    data['couponIdNo'] = this.couponIdNo;
    data['__v'] = this.iV;
    return data;
  }
}

class ProductId {
  String? sId;
  String? userId;
  String? productName;
  String? productItemCode;
  int? gtin;
  String? description;
  String? retailPrice;
  String? offerPrice;
  String? productPhotoIdNo;
  List<Images>? images;
  String? productOnSale;
  String? itemUnit;
  String? itemExpiryDate;
  String? itemBatchNo;
  String? itemSerialNumber;
  String? itemAvailableQty;
  int? iV;

  ProductId(
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
      this.iV});

  ProductId.fromJson(Map<String, dynamic> json) {
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
    itemUnit = json['itemUnit'];
    itemExpiryDate = json['itemExpiryDate'];
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
    data['itemUnit'] = this.itemUnit;
    data['itemExpiryDate'] = this.itemExpiryDate;
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
