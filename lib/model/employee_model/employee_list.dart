class EmployeeList {
  bool? status;
  List<Data>? data;

  EmployeeList({this.status, this.data});

  EmployeeList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? salonId;
  String? fullname;
  String? photo;
  String? worktime;
  String? services;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.salonId,
      this.fullname,
      this.photo,
      this.worktime,
      this.services,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salonId = json['salon_id'];
    fullname = json['fullname'];
    photo = json['photo'];
    worktime = json['worktime'];
    services = json['services'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['salon_id'] = salonId;
    data['fullname'] = fullname;
    data['photo'] = photo;
    data['worktime'] = worktime;
    data['services'] = services;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
