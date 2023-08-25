// ignore_for_file: unnecessary_getters_setters

import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  String? _conversationId;
  String? _deletedId;
  bool? _isDeleted;
  String? _lastMsg;
  String? _newMsg;
  String? _time;
  ChatUser? _user;

  Conversation({
    String? conversationId,
    String? deletedId,
    bool? isDeleted,
    String? lastMsg,
    String? newMsg,
    String? time,
    ChatUser? user,
  }) {
    _conversationId = conversationId;
    _deletedId = deletedId;
    _isDeleted = isDeleted;
    _lastMsg = lastMsg;
    _newMsg = newMsg;
    _time = time;
    _user = user;
  }

  factory Conversation.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Conversation(
      conversationId: data?['conversationId'],
      deletedId: data?['deletedId'],
      isDeleted: data?['isDeleted'],
      lastMsg: data?['lastMsg'],
      newMsg: data?['newMsg'],
      time: data?['time'],
      user: data?['user'] != null ? ChatUser.fromJson(data?['user']) : null,
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      if (conversationId != null) "conversationId": _conversationId,
      if (deletedId != null) "deletedId": _deletedId,
      if (isDeleted != null) "isDeleted": _isDeleted,
      if (lastMsg != null) "lastMsg": _lastMsg,
      if (newMsg != null) "newMsg": _newMsg,
      if (time != null) "time": _time,
      if (user != null) "user": _user,
    };
  }

  Conversation.fromJson(Map<String, dynamic> json) {
    _conversationId = json["conversationId"];
    _deletedId = json["deletedId"];
    _isDeleted = json["isDeleted"];
    _lastMsg = json["lastMsg"];
    _newMsg = json["newMsg"];
    _time = json["time"];
    _user = ChatUser.fromJson(json["user"]);
  }

  Map<String, Object?> toJson() {
    return {
      "conversationId": _conversationId,
      "deletedId": _deletedId,
      "isDeleted": _isDeleted,
      "lastMsg": _lastMsg,
      "newMsg": _newMsg,
      "time": _time,
      "user": _user?.toJson(),
    };
  }

  ChatUser? get user => _user;

  String? get time => _time;

  String? get newMsg => _newMsg;

  String? get lastMsg => _lastMsg;

  bool? get isDeleted => _isDeleted;

  String? get deletedId => _deletedId;

  String? get conversationId => _conversationId;

  void setConversationId(String? value) {
    _conversationId = value;
  }
}

class ChatUser {
  int? _userid;
  String? _userIdentity;
  String? _username;
  String? _image;
  String? _address;
  String? _gender;
  int? _msgCount;

  ChatUser({
    int? userid,
    String? userIdentity,
    String? username,
    String? image,
    String? address,
    String? gender,
    int? msgCount,
  }) {
    _userid = userid;
    _userIdentity = userIdentity;
    _username = username;
    _image = image;
    _address = address;
    _gender = gender;
    _msgCount = msgCount;
  }

  Map<String, dynamic> toJson() {
    return {
      "userid": _userid,
      "userIdentity": _userIdentity,
      "username": _username,
      "image": _image,
      "address": _address,
      "gender": _gender,
      "msgCount": _msgCount,
    };
  }

  ChatUser.fromJson(Map<String, dynamic> json) {
    _userid = json['userid'];
    _userIdentity = json['userIdentity'];
    _username = json['username'];
    _image = json['image'];
    _address = json['address'];
    _gender = json['gender'];
    _msgCount = json['msgCount'];
  }

  int? get msgCount => _msgCount;

  set msgCount(int? value) {
    _msgCount = value;
  }

  String? get address => _address;

  String? get image => _image;

  String? get username => _username;

  String? get userIdentity => _userIdentity;

  int? get userid => _userid;

  String? get gender => _gender;

  set gender(String? value) {
    _gender = value;
  }

  set address(String? value) {
    _address = value;
  }

  set image(String? value) {
    _image = value;
  }

  set username(String? value) {
    _username = value;
  }

  set userid(int? value) {
    _userid = value;
  }
}

class ChatMessage {
  String? _id;
  String? _msgType;
  String? _image;
  String? _video;
  String? _msg;
  ChatUser? _senderUser;
  List<String>? _notDeletedIdentities;

  ChatMessage(
      {String? id,
      String? image,
      String? video,
      String? msg,
      String? msgType,
      ChatUser? senderUser,
      List<String>? notDeletedIdentities}) {
    _id = id;
    _image = image;
    _video = video;
    _msg = msg;
    _msgType = msgType;
    _senderUser = senderUser;
    _notDeletedIdentities = notDeletedIdentities;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": _id,
      "image": _image,
      "video": _video,
      "msg": _msg,
      "msgType": _msgType,
      "senderUser": _senderUser?.toJson(),
      "not_deleted_identities": _notDeletedIdentities?.map((v) => v).toList()
    };
  }

  ChatMessage.fromJson(Map<String, dynamic>? json) {
    _id = json?["id"];
    _image = json?["image"];
    _video = json?["video"];
    _msg = json?["msg"];
    _msgType = json?["msgType"];
    _senderUser = ChatUser.fromJson(json?["senderUser"]);
    if (json?['not_deleted_identities'] != null) {
      _notDeletedIdentities = [];
      json?['not_deleted_identities'].forEach((v) {
        _notDeletedIdentities?.add(v);
      });
    }
  }

  factory ChatMessage.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    List<String> notDeletedIdentities = [];
    data?['not_deleted_identities'].forEach((v) {
      notDeletedIdentities.add(v);
    });
    return ChatMessage(
      image: data?['image'],
      video: data?['video'],
      id: data?['id'],
      msg: data?['msg'],
      msgType: data?['msgType'],
      notDeletedIdentities: notDeletedIdentities,
      senderUser: ChatUser.fromJson(data?["senderUser"]),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": _id,
      if (image != null) "image": _image,
      if (video != null) "video": _video,
      if (msg != null) "msg": _msg,
      if (msgType != null) "msgType": _msgType,
      if (senderUser != null) "senderUser": _senderUser,
      if (notDeletedIdentities != null)
        "not_deleted_identities": _notDeletedIdentities?.map((v) => v).toList()
    };
  }

  String? get video => _video;

  List<String>? get notDeletedIdentities => _notDeletedIdentities;

  ChatUser? get senderUser => _senderUser;

  String? get msgType => _msgType;

  String? get msg => _msg;

  String? get image => _image;

  String? get id => _id;
}
