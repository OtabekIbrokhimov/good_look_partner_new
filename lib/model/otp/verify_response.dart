// To parse this JSON data, do
//
//     final verifyResponse = verifyResponceFromJson(jsonString);

import 'dart:convert';

VerifyResponce verifyResponceFromJson(String str) => VerifyResponce.fromJson(json.decode(str));

String verifyResponceToJson(VerifyResponce data) => json.encode(data.toJson());

class VerifyResponce {
  bool? status;
  AccessToken? accessToken;
  String? message;

  VerifyResponce({
    this.status,
    this.accessToken,
    this.message,
  });

  factory VerifyResponce.fromJson(Map<String, dynamic> json) => VerifyResponce(
    status: json["status"],
    accessToken: AccessToken.fromJson(json["access_token"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "access_token": accessToken?.toJson(),
    "message": message,
  };
}


AccessToken accessTokenFromJson(String str) => AccessToken.fromJson(json.decode(str));

String accessTokenToJson(AccessToken data) => json.encode(data.toJson());
class AccessToken {
  String name;
  List<String> abilities;
  int tokenableId;
  String tokenableType;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  AccessToken({
    required this.name,
    required this.abilities,
    required this.tokenableId,
    required this.tokenableType,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory AccessToken.fromJson(Map<String, dynamic> json) => AccessToken(
    name: json["name"],
    abilities: List<String>.from(json["abilities"].map((x) => x)),
    tokenableId: json["tokenable_id"],
    tokenableType: json["tokenable_type"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "abilities": List<dynamic>.from(abilities.map((x) => x)),
    "tokenable_id": tokenableId,
    "tokenable_type": tokenableType,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}