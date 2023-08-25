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
