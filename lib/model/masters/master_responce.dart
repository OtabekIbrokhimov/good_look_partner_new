class MasterList {
  bool? status;
  List<Master>? data;

  MasterList({this.status, this.data});

  MasterList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Master>[];
      json['data'].forEach((v) {
        data!.add(Master.fromJson(v));
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

class Master {
  int? id;
  int? salonId;
  String? fullname;
  String? photo;
  String? worktime;
  String? services;
  String? createdAt;
  String? updatedAt;
  String? freetime;
  String? vacationtime;

  Master(
      {this.id,
      this.salonId,
      this.fullname,
      this.photo,
      this.worktime,
      this.services,
      this.createdAt,
      this.updatedAt,
      this.freetime,
      this.vacationtime});

  Master.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salonId = json['salon_id'];
    fullname = json['fullname'];
    photo = json['photo'];
    worktime = json['worktime'];
    services = json['services'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    freetime = json['freetime'];
    vacationtime = json['vacationtime'];
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
    data['vacationtime'] = vacationtime;
    data['freetime'] = freetime;
    return data;
  }
}
