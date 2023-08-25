class SalonUser {
  SalonUser({
    bool? status,
    String? message,
    UserData? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  SalonUser.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  bool? _status;
  String? _message;
  UserData? _data;

  SalonUser copyWith({
    bool? status,
    String? message,
    UserData? data,
  }) =>
      SalonUser(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  UserData? get data => _data;

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

class UserData {
  UserData({
    num? id,
    num? isBlock,
    String? identity,
    String? fullname,
    String? email,
    String? phoneNumber,
    String? profileImage,
    num? isNotification,
    num? deviceType,
    String? deviceToken,
    num? loginType,
    num? wallet,
    String? favouriteSalons,
    String? favouriteServices,
    dynamic couponsUsed,
    String? createdAt,
    String? updatedAt,
    num? bookingsCount,
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
    _bookingsCount = bookingsCount;
  }

  UserData.fromJson(dynamic json) {
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
    _bookingsCount = json['bookings_count'];
  }

  num? _id;
  num? _isBlock;
  String? _identity;
  String? _fullname;
  String? _email;
  String? _phoneNumber;
  String? _profileImage;
  num? _isNotification;
  num? _deviceType;
  String? _deviceToken;
  num? _loginType;
  num? _wallet;
  String? _favouriteSalons;
  String? _favouriteServices;
  dynamic _couponsUsed;
  String? _createdAt;
  String? _updatedAt;
  num? _bookingsCount;

  UserData copyWith({
    num? id,
    num? isBlock,
    String? identity,
    String? fullname,
    String? email,
    String? phoneNumber,
    String? profileImage,
    num? isNotification,
    num? deviceType,
    String? deviceToken,
    num? loginType,
    num? wallet,
    String? favouriteSalons,
    String? favouriteServices,
    dynamic couponsUsed,
    String? createdAt,
    String? updatedAt,
    num? bookingsCount,
  }) =>
      UserData(
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
        bookingsCount: bookingsCount ?? _bookingsCount,
      );

  num? get id => _id;

  num? get isBlock => _isBlock;

  String? get identity => _identity;

  String? get fullname => _fullname;

  String? get email => _email;

  String? get phoneNumber => _phoneNumber;

  String? get profileImage => _profileImage;

  num? get isNotification => _isNotification;

  num? get deviceType => _deviceType;

  String? get deviceToken => _deviceToken;

  num? get loginType => _loginType;

  num? get wallet => _wallet;

  String? get favouriteSalons => _favouriteSalons;

  String? get favouriteServices => _favouriteServices;

  dynamic get couponsUsed => _couponsUsed;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  num? get bookingsCount => _bookingsCount;

  bool isFavouriteSalon(int salonID) {
    List<String> ids = favouriteSalons?.split(',') ?? [];
    return ids.contains(salonID.toString());
  }

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
    map['bookings_count'] = _bookingsCount;
    return map;
  }
}
