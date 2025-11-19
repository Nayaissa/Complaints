class GetComlaintsModel {
  bool? success;
  String? message;
  List<Data>? data;
  int? statusCode;
  String? timestamp;

  GetComlaintsModel(
      {this.success, this.message, this.data, this.statusCode, this.timestamp});

  GetComlaintsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    statusCode = json['status_code'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status_code'] = this.statusCode;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Data {
  int? id;
  String? type;
  String? address;
  String? description;
  String? file;
  int? agencyId;
  int? userId;
  int? status;
  Null? noti;
  Null? lockedBy;
  Null? lockedAt;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.type,
      this.address,
      this.description,
      this.file,
      this.agencyId,
      this.userId,
      this.status,
      this.noti,
      this.lockedBy,
      this.lockedAt,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    address = json['address'];
    description = json['description'];
    file = json['file'];
    agencyId = json['agency_id'];
    userId = json['user_id'];
    status = json['status'];
    noti = json['noti'];
    lockedBy = json['locked_by'];
    lockedAt = json['locked_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['address'] = this.address;
    data['description'] = this.description;
    data['file'] = this.file;
    data['agency_id'] = this.agencyId;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['noti'] = this.noti;
    data['locked_by'] = this.lockedBy;
    data['locked_at'] = this.lockedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}