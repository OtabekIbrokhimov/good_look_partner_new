import 'dart:convert';

import 'package:cutfx_salon/model/order_summary.dart';
import 'package:cutfx_salon/model/user/salon.dart';

class RequestDetails {
  RequestDetails({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  RequestDetails.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _status;
  String? _message;
  Data? _data;

  RequestDetails copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      RequestDetails(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
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
    Salon? salon,
    User? user,
    dynamic review,
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
    _salon = salon;
    _user = user;
    _review = review;
  }

  Data.fromJson(dynamic json) {
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
    _salon = json['salon'] != null ? Salon.fromJson(json['salon']) : null;
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _review = json['review'];
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
  Salon? _salon;
  User? _user;
  dynamic _review;

  Data copyWith({
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
    Salon? salon,
    User? user,
    dynamic review,
  }) =>
      Data(
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
        salon: salon ?? _salon,
        user: user ?? _user,
        review: review ?? _review,
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

  Salon? get salon => _salon;

  User? get user => _user;

  dynamic get review => _review;

  List<Services> convertService() {
    services = [];
    OrderSummary orderSummary = getOrderSummary();
    services = orderSummary.services ?? [];
    return services ?? [];
  }

  OrderSummary getOrderSummary() {
    return OrderSummary.fromJson(jsonDecode(_services ?? ''));
  }

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
    if (_salon != null) {
      map['salon'] = _salon?.toJson();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['review'] = _review;
    convertService();
    return map;
  }
}

class User {
  User({
    num? id,
    num? isBlock,
    String? identity,
    String? fullname,
    dynamic email,
    String? phoneNumber,
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
  String? _phoneNumber;
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

  String? get phoneNumber => _phoneNumber;

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

class Salon {
  Salon({
    num? id,
    num? wallet,
    num? lifetimeEarnings,
    num? deviceType,
    num? status,
    num? topRated,
    num? isNotification,
    num? onVacation,
    num? rating,
    String? salonNumber,
    String? email,
    String? salonName,
    String? ownerName,
    String? ownerPhoto,
    String? salonAbout,
    String? salonAddress,
    String? salonPhone,
    String? salonLat,
    String? salonLong,
    String? salonCategories,
    num? genderServed,
    String? monFriFrom,
    String? monFriTo,
    String? satSunFrom,
    String? satSunTo,
    String? deviceToken,
    num? totalRejectedBookings,
    num? totalCompletedBookings,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _wallet = wallet;
    _lifetimeEarnings = lifetimeEarnings;
    _deviceType = deviceType;
    _status = status;
    _topRated = topRated;
    _isNotification = isNotification;
    _onVacation = onVacation;
    _rating = rating;
    _salonNumber = salonNumber;
    _email = email;
    _salonName = salonName;
    _ownerName = ownerName;
    _ownerPhoto = ownerPhoto;
    _salonAbout = salonAbout;
    _salonAddress = salonAddress;
    _salonPhone = salonPhone;
    _salonLat = salonLat;
    _salonLong = salonLong;
    _salonCategories = salonCategories;
    _genderServed = genderServed;
    _monFriFrom = monFriFrom;
    _monFriTo = monFriTo;
    _satSunFrom = satSunFrom;
    _satSunTo = satSunTo;
    _deviceToken = deviceToken;
    _totalRejectedBookings = totalRejectedBookings;
    _totalCompletedBookings = totalCompletedBookings;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Salon.fromJson(dynamic json) {
    _id = json['id'];
    _wallet = json['wallet'];
    _lifetimeEarnings = json['lifetime_earnings'];
    _deviceType = json['device_type'];
    _status = json['status'];
    _topRated = json['top_rated'];
    _isNotification = json['is_notification'];
    _onVacation = json['on_vacation'];
    _rating = json['rating'];
    _salonNumber = json['salon_number'];
    _email = json['email'];
    _salonName = json['salon_name'];
    _ownerName = json['owner_name'];
    _ownerPhoto = json['owner_photo'];
    _salonAbout = json['salon_about'];
    _salonAddress = json['salon_address'];
    _salonPhone = json['salon_phone'];
    _salonLat = json['salon_lat'];
    _salonLong = json['salon_long'];
    _salonCategories = json['salon_categories'];
    _genderServed = json['gender_served'];
    _monFriFrom = json['mon_fri_from'];
    _monFriTo = json['mon_fri_to'];
    _satSunFrom = json['sat_sun_from'];
    _satSunTo = json['sat_sun_to'];
    _deviceToken = json['device_token'];
    _totalRejectedBookings = json['total_rejected_bookings'];
    _totalCompletedBookings = json['total_completed_bookings'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  num? _wallet;
  num? _lifetimeEarnings;
  num? _deviceType;
  num? _status;
  num? _topRated;
  num? _isNotification;
  num? _onVacation;
  num? _rating;
  String? _salonNumber;
  String? _email;
  String? _salonName;
  String? _ownerName;
  String? _ownerPhoto;
  String? _salonAbout;
  String? _salonAddress;
  String? _salonPhone;
  String? _salonLat;
  String? _salonLong;
  String? _salonCategories;
  num? _genderServed;
  String? _monFriFrom;
  String? _monFriTo;
  String? _satSunFrom;
  String? _satSunTo;
  String? _deviceToken;
  num? _totalRejectedBookings;
  num? _totalCompletedBookings;
  String? _createdAt;
  String? _updatedAt;

  Salon copyWith({
    num? id,
    num? wallet,
    num? lifetimeEarnings,
    num? deviceType,
    num? status,
    num? topRated,
    num? isNotification,
    num? onVacation,
    num? rating,
    String? salonNumber,
    String? email,
    String? salonName,
    String? ownerName,
    String? ownerPhoto,
    String? salonAbout,
    String? salonAddress,
    String? salonPhone,
    String? salonLat,
    String? salonLong,
    String? salonCategories,
    num? genderServed,
    String? monFriFrom,
    String? monFriTo,
    String? satSunFrom,
    String? satSunTo,
    String? deviceToken,
    num? totalRejectedBookings,
    num? totalCompletedBookings,
    String? createdAt,
    String? updatedAt,
  }) =>
      Salon(
        id: id ?? _id,
        wallet: wallet ?? _wallet,
        lifetimeEarnings: lifetimeEarnings ?? _lifetimeEarnings,
        deviceType: deviceType ?? _deviceType,
        status: status ?? _status,
        topRated: topRated ?? _topRated,
        isNotification: isNotification ?? _isNotification,
        onVacation: onVacation ?? _onVacation,
        rating: rating ?? _rating,
        salonNumber: salonNumber ?? _salonNumber,
        email: email ?? _email,
        salonName: salonName ?? _salonName,
        ownerName: ownerName ?? _ownerName,
        ownerPhoto: ownerPhoto ?? _ownerPhoto,
        salonAbout: salonAbout ?? _salonAbout,
        salonAddress: salonAddress ?? _salonAddress,
        salonPhone: salonPhone ?? _salonPhone,
        salonLat: salonLat ?? _salonLat,
        salonLong: salonLong ?? _salonLong,
        salonCategories: salonCategories ?? _salonCategories,
        genderServed: genderServed ?? _genderServed,
        monFriFrom: monFriFrom ?? _monFriFrom,
        monFriTo: monFriTo ?? _monFriTo,
        satSunFrom: satSunFrom ?? _satSunFrom,
        satSunTo: satSunTo ?? _satSunTo,
        deviceToken: deviceToken ?? _deviceToken,
        totalRejectedBookings: totalRejectedBookings ?? _totalRejectedBookings,
        totalCompletedBookings:
            totalCompletedBookings ?? _totalCompletedBookings,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get wallet => _wallet;

  num? get lifetimeEarnings => _lifetimeEarnings;

  num? get deviceType => _deviceType;

  num? get status => _status;

  num? get topRated => _topRated;

  num? get isNotification => _isNotification;

  num? get onVacation => _onVacation;

  num? get rating => _rating;

  String? get salonNumber => _salonNumber;

  String? get email => _email;

  String? get salonName => _salonName;

  String? get ownerName => _ownerName;

  String? get ownerPhoto => _ownerPhoto;

  String? get salonAbout => _salonAbout;

  String? get salonAddress => _salonAddress;

  String? get salonPhone => _salonPhone;

  String? get salonLat => _salonLat;

  String? get salonLong => _salonLong;

  String? get salonCategories => _salonCategories;

  num? get genderServed => _genderServed;

  String? get monFriFrom => _monFriFrom;

  String? get monFriTo => _monFriTo;

  String? get satSunFrom => _satSunFrom;

  String? get satSunTo => _satSunTo;

  String? get deviceToken => _deviceToken;

  num? get totalRejectedBookings => _totalRejectedBookings;

  num? get totalCompletedBookings => _totalCompletedBookings;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['wallet'] = _wallet;
    map['lifetime_earnings'] = _lifetimeEarnings;
    map['device_type'] = _deviceType;
    map['status'] = _status;
    map['top_rated'] = _topRated;
    map['is_notification'] = _isNotification;
    map['on_vacation'] = _onVacation;
    map['rating'] = _rating;
    map['salon_number'] = _salonNumber;
    map['email'] = _email;
    map['salon_name'] = _salonName;
    map['owner_name'] = _ownerName;
    map['owner_photo'] = _ownerPhoto;
    map['salon_about'] = _salonAbout;
    map['salon_address'] = _salonAddress;
    map['salon_phone'] = _salonPhone;
    map['salon_lat'] = _salonLat;
    map['salon_long'] = _salonLong;
    map['salon_categories'] = _salonCategories;
    map['gender_served'] = _genderServed;
    map['mon_fri_from'] = _monFriFrom;
    map['mon_fri_to'] = _monFriTo;
    map['sat_sun_from'] = _satSunFrom;
    map['sat_sun_to'] = _satSunTo;
    map['device_token'] = _deviceToken;
    map['total_rejected_bookings'] = _totalRejectedBookings;
    map['total_completed_bookings'] = _totalCompletedBookings;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
