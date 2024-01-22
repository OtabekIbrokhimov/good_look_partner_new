import 'package:cutfx_salon/model/bank/bank.dart';
import 'package:cutfx_salon/model/service/services.dart';
import 'package:cutfx_salon/model/slot/slot.dart';

class Salon {
  Salon({
    bool? status,
    String? message,
    SalonData? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  Salon.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? SalonData.fromJson(json['data']) : null;
  }

  bool? _status;
  String? _message;
  SalonData? _data;

  Salon copyWith({
    bool? status,
    String? message,
    SalonData? data,
  }) =>
      Salon(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  SalonData? get data => _data;

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

class SalonData {
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
  num? _reviewsCount;
  String? _phoneNumber;
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
  List<Categories>? _categories;
  List<Images>? _images;
  List<Gallery>? _gallery;
  List<Awards>? _awards;
  List<SlotData>? _slots;
  BankAccount? _bankAccount;

  SalonData({
    num? id,
    num? wallet,
    num? lifetimeEarnings,
    num? deviceType,
    num? status,
    num? topRated,
    num? isNotification,
    num? onVacation,
    num? rating,
    num? reviewsCount,
    String? salonNumber,
    String? phoneNumber,
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
    List<Categories>? categories,
    List<Images>? images,
    List<Gallery>? gallery,
    List<Awards>? awards,
    List<SlotData>? slots,
    BankAccount? bankAccount,
  }) {
    _id = id;
    _wallet = num.tryParse(wallet.toString());
    _lifetimeEarnings = lifetimeEarnings;
    _deviceType = deviceType;
    _status = status;
    _topRated = topRated;
    _isNotification = isNotification;
    _onVacation = onVacation;
    _rating = rating;
    _reviewsCount = reviewsCount;
    _salonNumber = salonNumber;
    _phoneNumber = phoneNumber;
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
    _categories = categories;
    _images = images;
    _gallery = gallery;
    _awards = awards;
    _slots = slots;
    _bankAccount = bankAccount;
  }

  SalonData.fromJson(dynamic json) {
    _id = json['id'];
    _wallet = num.tryParse(json['wallet'].toString());
    _lifetimeEarnings = num.tryParse(json['lifetime_earnings'].toString());
    _deviceType = num.tryParse(json['device_type'].toString());
    _status = num.tryParse(json['status'].toString());
    _topRated = num.tryParse(json['top_rated'].toString());
    _isNotification = num.tryParse(json['is_notification'].toString());
    _onVacation = num.tryParse(json['on_vacation'].toString());
    _rating = num.tryParse(json['rating'].toString());
    _reviewsCount = num.tryParse(json['reviews_count'].toString());
    _salonNumber = json['salon_number'];
    _phoneNumber = json['phone_number'];
    _salonName = json['salon_name'];
    _ownerName = json['owner_name'];
    _ownerPhoto = json['owner_photo'];
    _salonAbout = json['salon_about'];
    _salonAddress = json['salon_address'];
    _salonPhone = json['salon_phone'];
    _salonLat = json['salon_lat'];
    _salonLong = json['salon_long'];
    _salonCategories = json['salon_categories'];
    _genderServed = num.tryParse(json['gender_served'].toString());
    _monFriFrom = json['mon_fri_from'];
    _monFriTo = json['mon_fri_to'];
    _satSunFrom = json['sat_sun_from'];
    _satSunTo = json['sat_sun_to'];
    _deviceToken = json['device_token'];
    _totalRejectedBookings =
        num.tryParse(json['total_rejected_bookings'].toString());
    _totalCompletedBookings =
        num.tryParse(json['total_completed_bookings'].toString());
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['bank_account'] != null) {
      _bankAccount = BankAccount.fromJson(json['bank_account']);
    }
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(Categories.fromJson(v));
      });
    }
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
    if (json['gallery'] != null) {
      _gallery = [];
      json['gallery'].forEach((v) {
        _gallery?.add(Gallery.fromJson(v));
      });
    }
    if (json['awards'] != null) {
      _awards = [];
      json['awards'].forEach((v) {
        _awards?.add(Awards.fromJson(v));
      });
    }
    if (json['slots'] != null) {
      _slots = [];
      json['slots'].forEach((v) {
        _slots?.add(SlotData.fromJson(v));
      });
    }
  }

  SalonData copyWith({
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
    String? phoneNumber,
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
    List<Categories>? categories,
    List<Images>? images,
    List<Gallery>? gallery,
    List<Awards>? awards,
    List<SlotData>? slots,
    BankAccount? bankAccount,
  }) =>
      SalonData(
        id: id ?? _id,
        wallet: wallet ?? _wallet,
        lifetimeEarnings: lifetimeEarnings ?? _lifetimeEarnings,
        deviceType: deviceType ?? _deviceType,
        status: status ?? _status,
        topRated: topRated ?? _topRated,
        isNotification: isNotification ?? _isNotification,
        onVacation: onVacation ?? _onVacation,
        rating: rating ?? _rating,
        reviewsCount: reviewsCount ?? _reviewsCount,
        salonNumber: salonNumber ?? _salonNumber,
        phoneNumber: phoneNumber ?? _phoneNumber,
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
        categories: categories ?? _categories,
        images: images ?? _images,
        gallery: gallery ?? _gallery,
        awards: awards ?? _awards,
        slots: slots ?? _slots,
        bankAccount: bankAccount ?? _bankAccount,
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

  num? get reviewsCount => _reviewsCount;

  String? get salonNumber => _salonNumber;

  String? get phoneNumber => _phoneNumber;

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

  List<Categories>? get categories => removeEmptyService();

  List<Categories>? removeEmptyService() {
    List<Categories>? categories1 = [];
    categories1 =
        _categories?.where((element) => element.services!.isNotEmpty).toList();
    return categories1;
  }

  List<Images>? get images => _images;

  List<Gallery>? get gallery => _gallery;

  List<Awards>? get awards => _awards;

  List<SlotData>? get slots => _slots;

  BankAccount? get bankAccount => _bankAccount;

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
    map['reviews_count'] = _reviewsCount;
    map['salon_number'] = _salonNumber;
    map['phone_number'] = _phoneNumber;
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
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    if (_gallery != null) {
      map['gallery'] = _gallery?.map((v) => v.toJson()).toList();
    }
    if (_awards != null) {
      map['awards'] = _awards?.map((v) => v.toJson()).toList();
    }
    if (_slots != null) {
      map['slots'] = _slots?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Awards {
  Awards({
    num? id,
    num? salonId,
    String? title,
    String? awardBy,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _salonId = salonId;
    _title = title;
    _awardBy = awardBy;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Awards.fromJson(dynamic json) {
    _id = json['id'];
    _salonId = num.tryParse(json['salon_id'].toString());
    _title = json['title'];
    _awardBy = json['award_by'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  num? _salonId;
  String? _title;
  String? _awardBy;
  String? _description;
  String? _createdAt;
  String? _updatedAt;

  Awards copyWith({
    num? id,
    num? salonId,
    String? title,
    String? awardBy,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) =>
      Awards(
        id: id ?? _id,
        salonId: salonId ?? _salonId,
        title: title ?? _title,
        awardBy: awardBy ?? _awardBy,
        description: description ?? _description,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get salonId => _salonId;

  String? get title => _title;

  String? get awardBy => _awardBy;

  String? get description => _description;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['salon_id'] = _salonId;
    map['title'] = _title;
    map['award_by'] = _awardBy;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Gallery {
  Gallery({
    num? id,
    num? salonId,
    String? image,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _salonId = salonId;
    _image = image;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Gallery.fromJson(dynamic json) {
    _id = json['id'];
    _salonId = json['salon_id'];
    _image = json['image'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  num? _salonId;
  String? _image;
  String? _description;
  String? _createdAt;
  String? _updatedAt;

  Gallery copyWith({
    num? id,
    num? salonId,
    String? image,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) =>
      Gallery(
        id: id ?? _id,
        salonId: salonId ?? _salonId,
        image: image ?? _image,
        description: description ?? _description,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get salonId => _salonId;

  String? get image => _image;

  String? get description => _description;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['salon_id'] = _salonId;
    map['image'] = _image;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Images {
  Images({
    num? id,
    num? salonId,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _salonId = salonId;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Images.fromJson(dynamic json) {
    _id = json['id'];
    _salonId = num.tryParse(json['salon_id'].toString());
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  num? _salonId;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  Images copyWith({
    num? id,
    num? salonId,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) =>
      Images(
        id: id ?? _id,
        salonId: salonId ?? _salonId,
        image: image ?? _image,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get salonId => _salonId;

  String? get image => _image;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['salon_id'] = _salonId;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Categories {
  Categories({
    num? id,
    String? title,
    dynamic icon,
    num? isDeleted,
    String? createdAt,
    String? updatedAt,
    List<Services>? services,
  }) {
    _id = id;
    _title = title;
    _icon = icon;
    _isDeleted = isDeleted;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _services = services;
  }

  Categories.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _icon = json['icon'];
    _isDeleted = num.tryParse(json['is_deleted'].toString());
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['services'] != null) {
      _services = [];
      json['services'].forEach((v) {
        _services?.add(Services.fromJson(v));
      });
    }
  }

  num? _id;
  String? _title;
  dynamic _icon;
  num? _isDeleted;
  String? _createdAt;
  String? _updatedAt;
  List<Services>? _services;

  Categories copyWith({
    num? id,
    String? title,
    dynamic icon,
    num? isDeleted,
    String? createdAt,
    String? updatedAt,
    List<Services>? services,
  }) =>
      Categories(
        id: id ?? _id,
        title: title ?? _title,
        icon: icon ?? _icon,
        isDeleted: isDeleted ?? _isDeleted,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        services: services ?? _services,
      );

  num? get id => _id;

  String? get title => _title;

  dynamic get icon => _icon;

  num? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  List<Services>? get services => _services;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['icon'] = _icon;
    map['is_deleted'] = _isDeleted;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_services != null) {
      map['services'] = _services?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Services {
  Services({
    num? id,
    num? status,
    String? serviceNumber,
    num? categoryId,
    num? salonId,
    String? title,
    num? price,
    num? discount,
    num? gender,
    String? about,
    String? createdAt,
    String? updatedAt,
    List<Images>? images,
    Category? category,
    int? serviceTime,
  }) {
    _id = id;
    _status = status;
    _serviceNumber = serviceNumber;
    _categoryId = categoryId;
    _salonId = salonId;
    _title = title;
    _price = price;
    _discount = discount;
    _gender = gender;
    _about = about;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _images = images;
    _category = category;
    _serviceTime = serviceTime;
  }

  Services.fromJson(dynamic json) {
    _id = json['id'];
    _status = num.tryParse(json['status'].toString());
    _serviceNumber = json['service_number'];
    _categoryId = num.tryParse(json['category_id'].toString());
    _salonId = num.tryParse(json['salon_id'].toString());
    _title = json['title'];
    _price = num.tryParse(json['price'].toString());
    _discount = num.tryParse(json['discount'].toString());
    _gender = num.tryParse(json['gender'].toString());
    _about = json['about'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _serviceTime = int.tryParse(json['service_time'].toString());
    if (json['category'] != null) {
      _category = Category.fromJson(json['category']);
    }
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
  }

  num? _id;
  num? _status;
  String? _serviceNumber;
  num? _categoryId;
  num? _salonId;
  String? _title;
  num? _price;
  num? _discount;
  num? _gender;
  String? _about;
  String? _createdAt;
  String? _updatedAt;
  List<Images>? _images;
  Category? _category;
  int? _serviceTime;

  Services copyWith({
    num? id,
    num? status,
    String? serviceNumber,
    num? categoryId,
    num? salonId,
    String? title,
    num? price,
    num? discount,
    num? gender,
    String? about,
    String? createdAt,
    String? updatedAt,
    List<Images>? images,
    Category? category,
    int? serviceTime,
  }) =>
      Services(
        id: id ?? _id,
        status: status ?? _status,
        serviceNumber: serviceNumber ?? _serviceNumber,
        categoryId: categoryId ?? _categoryId,
        salonId: salonId ?? _salonId,
        title: title ?? _title,
        price: price ?? _price,
        discount: discount ?? _discount,
        gender: gender ?? _gender,
        about: about ?? _about,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        images: images ?? _images,
        category: category ?? _category,
        serviceTime: serviceTime ?? _serviceTime,
      );

  num? get id => _id;

  num? get status => _status;

  String? get serviceNumber => _serviceNumber;

  num? get categoryId => _categoryId;

  num? get salonId => _salonId;

  String? get title => _title;

  num? get price => _price;

  num? get discount => _discount;

  num? get gender => _gender;

  String? get about => _about;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Category? get category => _category;

  int? get serviceTime => _serviceTime;

  List<Images>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['status'] = _status;
    map['service_number'] = _serviceNumber;
    map['category_id'] = _categoryId;
    map['salon_id'] = _salonId;
    map['title'] = _title;
    map['price'] = _price;
    map['discount'] = _discount;
    map['gender'] = _gender;
    map['about'] = _about;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['category'] = _category?.toJson();
    map['service_time'] = _serviceTime;
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
