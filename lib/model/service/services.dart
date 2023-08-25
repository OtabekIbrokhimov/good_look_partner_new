class Services {
  Services({
    bool? status,
    String? message,
    List<ServiceData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  Services.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ServiceData.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<ServiceData>? _data;

  Services copyWith({
    bool? status,
    String? message,
    List<ServiceData>? data,
  }) =>
      Services(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  List<ServiceData>? get data => _data;

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

class ServiceData {
  ServiceData(
      {int? id,
      int? status,
      String? serviceNumber,
      int? categoryId,
      int? salonId,
      String? title,
      int? serviceTime,
      int? price,
      int? discount,
      int? gender,
      String? about,
      String? createdAt,
      String? updatedAt,
      List<Images>? images,
      Category? category}) {
    _id = id;
    _status = status;
    _serviceNumber = serviceNumber;
    _categoryId = categoryId;
    _salonId = salonId;
    _title = title;
    _serviceTime = serviceTime;
    _price = price;
    _discount = discount;
    _gender = gender;
    _about = about;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _images = images;
    _category = category;
  }

  ServiceData.fromJson(dynamic json) {
    _id = json['id'];
    _status = int.tryParse(json['status'].toString());
    _serviceNumber = json['service_number'];
    _categoryId = int.tryParse(json['category_id'].toString());
    _salonId = int.tryParse(json['salon_id'].toString());
    _title = json['title'];
    _serviceTime = int.tryParse(json['service_time'].toString());
    _price = int.tryParse(json['price'].toString());
    _discount = int.tryParse(json['discount'].toString());
    _gender = int.tryParse(json['gender'].toString());
    _about = json['about'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
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

  int? _id;
  int? _status;
  String? _serviceNumber;
  int? _categoryId;
  int? _salonId;
  String? _title;
  int? _serviceTime;
  int? _price;
  int? _discount;
  int? _gender;
  String? _about;
  String? _createdAt;
  String? _updatedAt;
  List<Images>? _images;
  Category? _category;

  ServiceData copyWith({
    int? id,
    int? status,
    String? serviceNumber,
    int? categoryId,
    int? salonId,
    String? title,
    int? serviceTime,
    int? price,
    int? discount,
    int? gender,
    String? about,
    String? createdAt,
    String? updatedAt,
    List<Images>? images,
    Category? category,
  }) =>
      ServiceData(
          id: id ?? _id,
          status: status ?? _status,
          serviceNumber: serviceNumber ?? _serviceNumber,
          categoryId: categoryId ?? _categoryId,
          salonId: salonId ?? _salonId,
          title: title ?? _title,
          serviceTime: serviceTime ?? _serviceTime,
          price: price ?? _price,
          discount: discount ?? _discount,
          gender: gender ?? _gender,
          about: about ?? _about,
          createdAt: createdAt ?? _createdAt,
          updatedAt: updatedAt ?? _updatedAt,
          images: images ?? _images,
          category: category ?? _category);

  int? get id => _id;

  int? get status => _status;

  String? get serviceNumber => _serviceNumber;

  int? get categoryId => _categoryId;

  int? get salonId => _salonId;

  String? get title => _title;

  int? get serviceTime => _serviceTime;

  int? get price => _price;

  int? get discount => _discount;

  int? get gender => _gender;

  String? get about => _about;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  List<Images>? get images => _images;

  Category? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['status'] = _status;
    map['service_number'] = _serviceNumber;
    map['category_id'] = _categoryId;
    map['salon_id'] = _salonId;
    map['title'] = _title;
    map['service_time'] = _serviceTime;
    map['price'] = _price;
    map['discount'] = _discount;
    map['gender'] = _gender;
    map['about'] = _about;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['category'] = _category?.toJson();
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Images {
  Images({
    int? id,
    int? serviceId,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _serviceId = serviceId;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Images.fromJson(dynamic json) {
    _id = json['id'];
    _serviceId = int.tryParse(json['service_id'].toString());
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  int? _serviceId;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  Images copyWith({
    int? id,
    int? serviceId,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) =>
      Images(
        id: id ?? _id,
        serviceId: serviceId ?? _serviceId,
        image: image ?? _image,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  int? get id => _id;

  int? get serviceId => _serviceId;

  String? get image => _image;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['service_id'] = _serviceId;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Category {
  Category({
    num? id,
    String? title,
    String? icon,
    num? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _title = title;
    _icon = icon;
    _isDeleted = isDeleted;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _icon = json['icon'];
    _isDeleted = num.tryParse(json['is_deleted'].toString());
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  String? _title;
  String? _icon;
  num? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  Category copyWith({
    num? id,
    String? title,
    String? icon,
    num? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) =>
      Category(
        id: id ?? _id,
        title: title ?? _title,
        icon: icon ?? _icon,
        isDeleted: isDeleted ?? _isDeleted,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  String? get title => _title;

  String? get icon => _icon;

  num? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['icon'] = _icon;
    map['is_deleted'] = _isDeleted;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
