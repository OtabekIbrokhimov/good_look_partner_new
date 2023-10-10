

import '../user/salon.dart';

/// status : true
/// message : "Data fetched successfully"
/// data : [{"id":9,"status":1,"booking_id":"SRU682471RJH","completion_otp":8585,"salon_id":2,"user_id":2,"date":"2023-03-15","time":"0940","duration":"2 Hours","services":"Services","is_coupon_applied":1,"coupon_title":"COUPON25","discount_amount":10,"total_amount":25,"payable_amount":15,"is_rated":1,"created_at":"2022-11-30T11:44:19.000000Z","updated_at":"2022-12-01T11:22:05.000000Z","user":{"id":2,"is_block":0,"identity":"pkotadiya04@gmail.com","fullname":"Parth Patel","email":null,"phone_number":null,"profile_image":"uploads/user.JPG","is_notification":1,"device_type":2,"device_token":"device_token2","login_type":2,"wallet":565,"favourite_salons":"1,2,3","favourite_services":"1,2,3","coupons_used":",1,2,2","created_at":"2022-11-25T07:27:09.000000Z","updated_at":"2023-03-03T12:14:56.000000Z"}}]


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



////
class Booking {
  bool? status;
  String? message;
  List<BookingData>? data;

  Booking({this.status, this.message, this.data});

  Booking.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BookingData>[];
      json['data'].forEach((v) {
        data!.add(BookingData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingData {
  int? id;
  int? status;
  String? bookingId;
  int? completionOtp;
  int? salonId;
  int? userId;
  String? date;
  String? time;
  String? duration;
  String? services;
  int? isCouponApplied;
  String? couponTitle;
  int? serviceAmount;
  int? discountAmount;
  int? subtotal;
  int? totalTaxAmount;
  int? payableAmount;
  int? isRated;
  String? createdAt;
  String? updatedAt;
  SalonData? salonData;
  User? user;

  BookingData(
      {this.id,
        this.status,
        this.bookingId,
        this.completionOtp,
        this.salonId,
        this.userId,
        this.date,
        this.time,
        this.duration,
        this.services,
        this.isCouponApplied,
        this.couponTitle,
        this.serviceAmount,
        this.discountAmount,
        this.subtotal,
        this.totalTaxAmount,
        this.payableAmount,
        this.isRated,
        this.createdAt,
        this.updatedAt,
        this.salonData,
        this.user});

  BookingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    bookingId = json['booking_id'];
    completionOtp = json['completion_otp'];
    salonId = json['salon_id'];
    userId = json['user_id'];
    date = json['date'];
    time = json['time'];
    duration = json['duration'];
    services = json['services'];
    isCouponApplied = json['is_coupon_applied'];
    couponTitle = json['coupon_title'];
    serviceAmount = json['service_amount'];
    discountAmount = json['discount_amount'];
    subtotal = json['subtotal'];
    totalTaxAmount = json['total_tax_amount'];
    payableAmount = json['payable_amount'];
    isRated = json['is_rated'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    salonData = (json['salon_data'] != null ? SalonData.fromJson(json['salon']) : null);
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['booking_id'] = bookingId;
    data['completion_otp'] = completionOtp;
    data['salon_id'] = salonId;
    data['user_id'] = userId;
    data['date'] = date;
    data['time'] = time;
    data['duration'] = duration;
    data['services'] = services;
    data['is_coupon_applied'] = isCouponApplied;
    data['coupon_title'] = couponTitle;
    data['service_amount'] = serviceAmount;
    data['discount_amount'] = discountAmount;
    data['subtotal'] = subtotal;
    data['total_tax_amount'] = totalTaxAmount;
    data['payable_amount'] = payableAmount;
    data['is_rated'] = isRated;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (salonData != null) {
      data['salon_data'] = salonData!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}


class Images {
  int? id;
  int? salonId;
  String? image;
  String? createdAt;
  String? updatedAt;

  Images({this.id, this.salonId, this.image, this.createdAt, this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salonId = json['salon_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['salon_id'] = salonId;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class User {
  int? id;
  int? isBlock;
  String? identity;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? profileImage;
  int? isNotification;
  int? deviceType;
  String? deviceToken;
  int? loginType;
  int? wallet;
  String? favouriteSalons;
  String? favouriteServices;
  String? couponsUsed;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.isBlock,
        this.identity,
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.profileImage,
        this.isNotification,
        this.deviceType,
        this.deviceToken,
        this.loginType,
        this.wallet,
        this.favouriteSalons,
        this.favouriteServices,
        this.couponsUsed,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isBlock = json['is_block'];
    identity = json['identity'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    profileImage = json['profile_image'];
    isNotification = json['is_notification'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    loginType = json['login_type'];
    wallet = json['wallet'];
    favouriteSalons = json['favourite_salons'];
    favouriteServices = json['favourite_services'];
    couponsUsed = json['coupons_used'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_block'] = isBlock;
    data['identity'] = identity;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    data['profile_image'] = profileImage;
    data['is_notification'] = isNotification;
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    data['login_type'] = loginType;
    data['wallet'] = wallet;
    data['favourite_salons'] = favouriteSalons;
    data['favourite_services'] = favouriteServices;
    data['coupons_used'] = couponsUsed;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}