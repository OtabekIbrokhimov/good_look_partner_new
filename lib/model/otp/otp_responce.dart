import 'dart:convert';

SendOtpResponce sendOtpResponceFromJson(String str) =>
    SendOtpResponce.fromJson(json.decode(str));

String sendOtpResponceToJson(SendOtpResponce data) =>
    json.encode(data.toJson());

class SendOtpResponce {
  SendOtpResponce({
    this.status,
    this.message,
    this.created,
  });

  bool? status;
  String? message;
  bool? created;

  factory SendOtpResponce.fromJson(Map<String, dynamic> json) =>
      SendOtpResponce(
        status: json["status"],
        message: json["message"],
        created: json["created"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "created": created,
  };
}