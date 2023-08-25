class Categories {
  Categories({
    bool? status,
    String? message,
    List<CategoryData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  Categories.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CategoryData.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<CategoryData>? _data;

  Categories copyWith({
    bool? status,
    String? message,
    List<CategoryData>? data,
  }) =>
      Categories(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  List<CategoryData>? get data => _data;

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

class CategoryData {
  CategoryData({
    int? id,
    String? title,
    dynamic icon,
    int? isDeleted,
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

  CategoryData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _icon = json['icon'];
    _isDeleted = int.tryParse(json['is_deleted'].toString());
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  String? _title;
  String? _icon;
  int? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  CategoryData copyWith({
    int? id,
    String? title,
    String? icon,
    int? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) =>
      CategoryData(
        id: id ?? _id,
        title: title ?? _title,
        icon: icon ?? _icon,
        isDeleted: isDeleted ?? _isDeleted,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  int? get id => _id;

  String? get title => _title;

  String? get icon => _icon;

  int? get isDeleted => _isDeleted;

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
