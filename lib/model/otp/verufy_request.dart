import 'dart:convert';

VerifyRequest VerifyRequestFromJson(String str) =>
    VerifyRequest.fromJson(json.decode(str));

String VerifyRequestToJson(VerifyRequest data) =>
    json.encode(data.toJson());

class VerifyRequest {
  String? userType;
  String? phoneNumber;
  String? otp;

  VerifyRequest({this.userType, this.phoneNumber, this.otp});

  VerifyRequest.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'];
    phoneNumber = json['phone_number'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_type'] = userType;
    data['phone_number'] = phoneNumber;
    data['otp'] = otp;
    return data;
  }
}