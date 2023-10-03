import 'dart:io';

class CreateEmployeeRequest {
  int? salonId;
  String? fullname;
  File? photo;
  List<WorkTime>? worktime;
  List<int>? services;
  int? status;

  CreateEmployeeRequest(
      {this.salonId,
      this.fullname,
      this.photo,
      this.worktime,
      this.services,
      this.status});

  CreateEmployeeRequest.fromJson(Map<String, dynamic> json) {
    salonId = json['salon_id'];
    fullname = json['fullname'];
    photo = json['photo'];
    if (json['worktime'] != null) {
      worktime = <WorkTime>[];
      json['worktime'].forEach((v) {
        worktime!.add(WorkTime.fromJson(v));
      });
    }
    services = json['services'].cast<int>();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['salon_id'] = salonId;
    data['fullname'] = fullname;
    data['photo'] = photo;
    if (worktime != null) {
      data['worktime'] = worktime!.map((v) => v.toJson()).toList();
    }
    data['services'] = services;
    data['status'] = status;
    return data;
  }
}

class WorkTime {
  String? date;
  String? start;
  String? end;

  WorkTime({this.date, this.start, this.end});

  WorkTime.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['start'] = start;
    data['end'] = end;
    return data;
  }
}
