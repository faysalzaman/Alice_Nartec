class GetAllAttendanceModel {
  bool? success;
  List<Data>? data;

  GetAllAttendanceModel({this.success, this.data});

  GetAllAttendanceModel.fromJson(Map<String, dynamic> json) {
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
  String? dateTime;
  String? typeofEntry;
  int? iV;

  Data({this.sId, this.userId, this.dateTime, this.typeofEntry, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    dateTime = json['dateTime'];
    typeofEntry = json['typeofEntry'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['dateTime'] = this.dateTime;
    data['typeofEntry'] = this.typeofEntry;
    data['__v'] = this.iV;
    return data;
  }
}
