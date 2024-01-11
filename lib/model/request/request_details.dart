

import 'package:cutfx_salon/model/review/salon_review.dart';

class RequestDetails {
  bool? status;
  String? message;
  Data? data;

  RequestDetails({this.status, this.message, this.data});

  RequestDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
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
  Salon? salon;
  User? user;
  SalonReview? review;

  Data(
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
        this.salon,
        this.user,
        this.review});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    bookingId = json['booking_id'];
    completionOtp = json['completion_otp'];
    salonId = json['salon_id'];
    userId = json['user_id'];
    date = json['date'];
    time = json['time'];
    duration = json['duration'];
    services = json['services'].toString();
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
    salon = json['salon'] != null ? Salon.fromJson(json['salon']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    review = json['review']!= null ? SalonReview.fromJson(json['review']) : null;
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
    if (salon != null) {
      data['salon'] = salon!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['review'] = review;
    return data;
  }
}

class Salon {
  int? id;
  int? wallet;
  int? lifetimeEarnings;
  int? deviceType;
  int? status;
  int? topRated;
  int? isNotification;
  int? onVacation;
  int? rating;
  String? salonNumber;
  String? phoneNumber;
  String? salonName;
  String? ownerName;
  String? ownerPhoto;
  String? salonAbout;
  String? salonAddress;
  String? salonPhone;
  String? salonLat;
  String? salonLong;
  String? salonCategories;
  int? genderServed;
  String? monFriFrom;
  String? monFriTo;
  String? satSunFrom;
  String? satSunTo;
  String? deviceToken;
  int? totalRejectedBookings;
  int? totalCompletedBookings;
  String? createdAt;
  String? updatedAt;
  List<Images>? images;

  Salon(
      {this.id,
        this.wallet,
        this.lifetimeEarnings,
        this.deviceType,
        this.status,
        this.topRated,
        this.isNotification,
        this.onVacation,
        this.rating,
        this.salonNumber,
        this.phoneNumber,
        this.salonName,
        this.ownerName,
        this.ownerPhoto,
        this.salonAbout,
        this.salonAddress,
        this.salonPhone,
        this.salonLat,
        this.salonLong,
        this.salonCategories,
        this.genderServed,
        this.monFriFrom,
        this.monFriTo,
        this.satSunFrom,
        this.satSunTo,
        this.deviceToken,
        this.totalRejectedBookings,
        this.totalCompletedBookings,
        this.createdAt,
        this.updatedAt,
        this.images});

  Salon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wallet = json['wallet'];
    lifetimeEarnings = json['lifetime_earnings'];
    deviceType = json['device_type'];
    status = json['status'];
    topRated = json['top_rated'];
    isNotification = json['is_notification'];
    onVacation = json['on_vacation'];
    rating = json['rating'];
    salonNumber = json['salon_number'];
    phoneNumber = json['phone_number'];
    salonName = json['salon_name'];
    ownerName = json['owner_name'];
    ownerPhoto = json['owner_photo'];
    salonAbout = json['salon_about'];
    salonAddress = json['salon_address'];
    salonPhone = json['salon_phone'];
    salonLat = json['salon_lat'];
    salonLong = json['salon_long'];
    salonCategories = json['salon_categories'];
    genderServed = json['gender_served'];
    monFriFrom = json['mon_fri_from'];
    monFriTo = json['mon_fri_to'];
    satSunFrom = json['sat_sun_from'];
    satSunTo = json['sat_sun_to'];
    deviceToken = json['device_token'];
    totalRejectedBookings = json['total_rejected_bookings'];
    totalCompletedBookings = json['total_completed_bookings'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['wallet'] = wallet;
    data['lifetime_earnings'] = lifetimeEarnings;
    data['device_type'] = deviceType;
    data['status'] = status;
    data['top_rated'] = topRated;
    data['is_notification'] = isNotification;
    data['on_vacation'] = onVacation;
    data['rating'] = rating;
    data['salon_number'] = salonNumber;
    data['phone_number'] = phoneNumber;
    data['salon_name'] = salonName;
    data['owner_name'] = ownerName;
    data['owner_photo'] = ownerPhoto;
    data['salon_about'] = salonAbout;
    data['salon_address'] = salonAddress;
    data['salon_phone'] = salonPhone;
    data['salon_lat'] = salonLat;
    data['salon_long'] = salonLong;
    data['salon_categories'] = salonCategories;
    data['gender_served'] = genderServed;
    data['mon_fri_from'] = monFriFrom;
    data['mon_fri_to'] = monFriTo;
    data['sat_sun_from'] = satSunFrom;
    data['sat_sun_to'] = satSunTo;
    data['device_token'] = deviceToken;
    data['total_rejected_bookings'] = totalRejectedBookings;
    data['total_completed_bookings'] = totalCompletedBookings;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data =  <String, dynamic>{};
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



