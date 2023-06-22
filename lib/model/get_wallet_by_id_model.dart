class GetWalletByIdModel {
  String? sId;
  String? userId;
  String? nfcSerialNumber;
  String? nfcCardType;
  String? nfcDetails;
  int? cardAvailableAmount;
  int? iV;

  GetWalletByIdModel(
      {this.sId,
      this.userId,
      this.nfcSerialNumber,
      this.nfcCardType,
      this.nfcDetails,
      this.cardAvailableAmount,
      this.iV});

  GetWalletByIdModel.fromJson(Map<String, dynamic> json) {
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
