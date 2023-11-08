import '../bookings/booking.dart';

class SalonReview {
  SalonReview({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  SalonReview.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<Data>? _data;

  SalonReview copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      SalonReview(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    num? id,
    num? userId,
    num? salonId,
    num? bookingId,
    num? rating,
    String? comment,
    String? createdAt,
    String? updatedAt,
    User? user,
  }) {
    _id = id;
    _userId = userId;
    _salonId = salonId;
    _bookingId = bookingId;
    _rating = rating;
    _comment = comment;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _salonId = json['salon_id'];
    _bookingId = json['booking_id'];
    _rating = json['rating'];
    _comment = json['comment'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  num? _id;
  num? _userId;
  num? _salonId;
  num? _bookingId;
  num? _rating;
  String? _comment;
  String? _createdAt;
  String? _updatedAt;
  User? _user;

  Data copyWith({
    num? id,
    num? userId,
    num? salonId,
    num? bookingId,
    num? rating,
    String? comment,
    String? createdAt,
    String? updatedAt,
    User? user,
  }) =>
      Data(
        id: id ?? _id,
        userId: userId ?? _userId,
        salonId: salonId ?? _salonId,
        bookingId: bookingId ?? _bookingId,
        rating: rating ?? _rating,
        comment: comment ?? _comment,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        user: user ?? _user,
      );

  num? get id => _id;

  num? get userId => _userId;

  num? get salonId => _salonId;

  num? get bookingId => _bookingId;

  num? get rating => _rating;

  String? get comment => _comment;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['salon_id'] = _salonId;
    map['booking_id'] = _bookingId;
    map['rating'] = _rating;
    map['comment'] = _comment;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}


