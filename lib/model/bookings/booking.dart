import 'dart:convert';

import 'package:cutfx_salon/model/order_summary.dart';
import 'package:cutfx_salon/model/user/salon.dart';

/// status : true
/// message : "Data fetched successfully"
/// data : [{"id":9,"status":1,"booking_id":"SRU682471RJH","completion_otp":8585,"salon_id":2,"user_id":2,"date":"2023-03-15","time":"0940","duration":"2 Hours","services":"Services","is_coupon_applied":1,"coupon_title":"COUPON25","discount_amount":10,"total_amount":25,"payable_amount":15,"is_rated":1,"created_at":"2022-11-30T11:44:19.000000Z","updated_at":"2022-12-01T11:22:05.000000Z","user":{"id":2,"is_block":0,"identity":"pkotadiya04@gmail.com","fullname":"Parth Patel","email":null,"phone_number":null,"profile_image":"uploads/user.JPG","is_notification":1,"device_type":2,"device_token":"device_token2","login_type":2,"wallet":565,"favourite_salons":"1,2,3","favourite_services":"1,2,3","coupons_used":",1,2,2","created_at":"2022-11-25T07:27:09.000000Z","updated_at":"2023-03-03T12:14:56.000000Z"}}]

class Booking {
  Booking({
    bool? status,
    String? message,
    List<BookingData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  Booking.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BookingData.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<BookingData>? _data;

  Booking copyWith({
    bool? status,
    String? message,
    List<BookingData>? data,
  }) =>
      Booking(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  List<BookingData>? get data => _data;

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

/// id : 9
/// status : 1
/// booking_id : "SRU682471RJH"
/// completion_otp : 8585
/// salon_id : 2
/// user_id : 2
/// date : "2023-03-15"
/// time : "0940"
/// duration : "2 Hours"
/// services : "Services"
/// is_coupon_applied : 1
/// coupon_title : "COUPON25"
/// discount_amount : 10
/// total_amount : 25
/// payable_amount : 15
/// is_rated : 1
/// created_at : "2022-11-30T11:44:19.000000Z"
/// updated_at : "2022-12-01T11:22:05.000000Z"
/// user : {"id":2,"is_block":0,"identity":"pkotadiya04@gmail.com","fullname":"Parth Patel","email":null,"phone_number":null,"profile_image":"uploads/user.JPG","is_notification":1,"device_type":2,"device_token":"device_token2","login_type":2,"wallet":565,"favourite_salons":"1,2,3","favourite_services":"1,2,3","coupons_used":",1,2,2","created_at":"2022-11-25T07:27:09.000000Z","updated_at":"2023-03-03T12:14:56.000000Z"}

class BookingData {
  BookingData({
    num? id,
    num? status,
    String? bookingId,
    num? completionOtp,
    num? salonId,
    num? userId,
    String? date,
    String? time,
    String? duration,
    String? services,
    num? isCouponApplied,
    String? couponTitle,
    num? discountAmount,
    num? totalAmount,
    num? payableAmount,
    num? isRated,
    String? createdAt,
    String? updatedAt,
    User? user,
  }) {
    _id = id;
    _status = status;
    _bookingId = bookingId;
    _completionOtp = completionOtp;
    _salonId = salonId;
    _userId = userId;
    _date = date;
    _time = time;
    _duration = duration;
    _services = services;
    _isCouponApplied = isCouponApplied;
    _couponTitle = couponTitle;
    _discountAmount = discountAmount;
    _totalAmount = totalAmount;
    _payableAmount = payableAmount;
    _isRated = isRated;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
    convertService();
  }

  BookingData.fromJson(dynamic json) {
    _id = json['id'];
    _status = json['status'];
    _bookingId = json['booking_id'];
    _completionOtp = json['completion_otp'];
    _salonId = json['salon_id'];
    _userId = json['user_id'];
    _date = json['date'];
    _time = json['time'];
    _duration = json['duration'];
    _services = json['services'];
    _isCouponApplied = json['is_coupon_applied'];
    _couponTitle = json['coupon_title'];
    _discountAmount = json['discount_amount'];
    _totalAmount = json['total_amount'];
    _payableAmount = json['payable_amount'];
    _isRated = json['is_rated'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    convertService();
  }

  num? _id;
  num? _status;
  String? _bookingId;
  num? _completionOtp;
  num? _salonId;
  num? _userId;
  String? _date;
  String? _time;
  String? _duration;
  String? _services;
  num? _isCouponApplied;
  String? _couponTitle;
  num? _discountAmount;
  num? _totalAmount;
  num? _payableAmount;
  num? _isRated;
  String? _createdAt;
  String? _updatedAt;
  User? _user;

  BookingData copyWith({
    num? id,
    num? status,
    String? bookingId,
    num? completionOtp,
    num? salonId,
    num? userId,
    String? date,
    String? time,
    String? duration,
    String? services,
    num? isCouponApplied,
    String? couponTitle,
    num? discountAmount,
    num? totalAmount,
    num? payableAmount,
    num? isRated,
    String? createdAt,
    String? updatedAt,
    User? user,
  }) =>
      BookingData(
        id: id ?? _id,
        status: status ?? _status,
        bookingId: bookingId ?? _bookingId,
        completionOtp: completionOtp ?? _completionOtp,
        salonId: salonId ?? _salonId,
        userId: userId ?? _userId,
        date: date ?? _date,
        time: time ?? _time,
        duration: duration ?? _duration,
        services: services ?? _services,
        isCouponApplied: isCouponApplied ?? _isCouponApplied,
        couponTitle: couponTitle ?? _couponTitle,
        discountAmount: discountAmount ?? _discountAmount,
        totalAmount: totalAmount ?? _totalAmount,
        payableAmount: payableAmount ?? _payableAmount,
        isRated: isRated ?? _isRated,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        user: user ?? _user,
      );

  num? get id => _id;

  num? get status => _status;

  String? get bookingId => _bookingId;

  num? get completionOtp => _completionOtp;

  num? get salonId => _salonId;

  num? get userId => _userId;

  String? get date => _date;

  String? get time => _time;

  String? get duration => _duration;

  List<Services>? services = [];

  num? get isCouponApplied => _isCouponApplied;

  String? get couponTitle => _couponTitle;

  num? get discountAmount => _discountAmount;

  num? get totalAmount => _totalAmount;

  num? get payableAmount => _payableAmount;

  num? get isRated => _isRated;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['status'] = _status;
    map['booking_id'] = _bookingId;
    map['completion_otp'] = _completionOtp;
    map['salon_id'] = _salonId;
    map['user_id'] = _userId;
    map['date'] = _date;
    map['time'] = _time;
    map['duration'] = _duration;
    map['services'] = _services;
    map['is_coupon_applied'] = _isCouponApplied;
    map['coupon_title'] = _couponTitle;
    map['discount_amount'] = _discountAmount;
    map['total_amount'] = _totalAmount;
    map['payable_amount'] = _payableAmount;
    map['is_rated'] = _isRated;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    convertService();
    return map;
  }

  List<Services> convertService() {
    services = [];
    OrderSummary orderSummary = getOrderSummary();
    services = orderSummary.services ?? [];
    return services ?? [];
  }

  OrderSummary getOrderSummary() {
    return OrderSummary.fromJson(jsonDecode(_services ?? ''));
  }
}

/// id : 2
/// is_block : 0
/// identity : "pkotadiya04@gmail.com"
/// fullname : "Parth Patel"
/// email : null
/// phone_number : null
/// profile_image : "uploads/user.JPG"
/// is_notification : 1
/// device_type : 2
/// device_token : "device_token2"
/// login_type : 2
/// wallet : 565
/// favourite_salons : "1,2,3"
/// favourite_services : "1,2,3"
/// coupons_used : ",1,2,2"
/// created_at : "2022-11-25T07:27:09.000000Z"
/// updated_at : "2023-03-03T12:14:56.000000Z"

class User {
  User({
    num? id,
    num? isBlock,
    String? identity,
    String? fullname,
    dynamic email,
    dynamic phoneNumber,
    String? profileImage,
    num? isNotification,
    num? deviceType,
    String? deviceToken,
    num? loginType,
    num? wallet,
    String? favouriteSalons,
    String? favouriteServices,
    String? couponsUsed,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _isBlock = isBlock;
    _identity = identity;
    _fullname = fullname;
    _email = email;
    _phoneNumber = phoneNumber;
    _profileImage = profileImage;
    _isNotification = isNotification;
    _deviceType = deviceType;
    _deviceToken = deviceToken;
    _loginType = loginType;
    _wallet = wallet;
    _favouriteSalons = favouriteSalons;
    _favouriteServices = favouriteServices;
    _couponsUsed = couponsUsed;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _isBlock = json['is_block'];
    _identity = json['identity'];
    _fullname = json['fullname'];
    _email = json['email'];
    _phoneNumber = json['phone_number'];
    _profileImage = json['profile_image'];
    _isNotification = json['is_notification'];
    _deviceType = json['device_type'];
    _deviceToken = json['device_token'];
    _loginType = json['login_type'];
    _wallet = json['wallet'];
    _favouriteSalons = json['favourite_salons'];
    _favouriteServices = json['favourite_services'];
    _couponsUsed = json['coupons_used'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  num? _isBlock;
  String? _identity;
  String? _fullname;
  dynamic _email;
  dynamic _phoneNumber;
  String? _profileImage;
  num? _isNotification;
  num? _deviceType;
  String? _deviceToken;
  num? _loginType;
  num? _wallet;
  String? _favouriteSalons;
  String? _favouriteServices;
  String? _couponsUsed;
  String? _createdAt;
  String? _updatedAt;

  User copyWith({
    num? id,
    num? isBlock,
    String? identity,
    String? fullname,
    dynamic email,
    dynamic phoneNumber,
    String? profileImage,
    num? isNotification,
    num? deviceType,
    String? deviceToken,
    num? loginType,
    num? wallet,
    String? favouriteSalons,
    String? favouriteServices,
    String? couponsUsed,
    String? createdAt,
    String? updatedAt,
  }) =>
      User(
        id: id ?? _id,
        isBlock: isBlock ?? _isBlock,
        identity: identity ?? _identity,
        fullname: fullname ?? _fullname,
        email: email ?? _email,
        phoneNumber: phoneNumber ?? _phoneNumber,
        profileImage: profileImage ?? _profileImage,
        isNotification: isNotification ?? _isNotification,
        deviceType: deviceType ?? _deviceType,
        deviceToken: deviceToken ?? _deviceToken,
        loginType: loginType ?? _loginType,
        wallet: wallet ?? _wallet,
        favouriteSalons: favouriteSalons ?? _favouriteSalons,
        favouriteServices: favouriteServices ?? _favouriteServices,
        couponsUsed: couponsUsed ?? _couponsUsed,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get isBlock => _isBlock;

  String? get identity => _identity;

  String? get fullname => _fullname;

  dynamic get email => _email;

  dynamic get phoneNumber => _phoneNumber;

  String? get profileImage => _profileImage;

  num? get isNotification => _isNotification;

  num? get deviceType => _deviceType;

  String? get deviceToken => _deviceToken;

  num? get loginType => _loginType;

  num? get wallet => _wallet;

  String? get favouriteSalons => _favouriteSalons;

  String? get favouriteServices => _favouriteServices;

  String? get couponsUsed => _couponsUsed;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['is_block'] = _isBlock;
    map['identity'] = _identity;
    map['fullname'] = _fullname;
    map['email'] = _email;
    map['phone_number'] = _phoneNumber;
    map['profile_image'] = _profileImage;
    map['is_notification'] = _isNotification;
    map['device_type'] = _deviceType;
    map['device_token'] = _deviceToken;
    map['login_type'] = _loginType;
    map['wallet'] = _wallet;
    map['favourite_salons'] = _favouriteSalons;
    map['favourite_services'] = _favouriteServices;
    map['coupons_used'] = _couponsUsed;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
