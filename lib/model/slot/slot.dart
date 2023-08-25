class Slot {
  Slot({
    bool? status,
    String? message,
    List<SlotData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  Slot.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SlotData.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<SlotData>? _data;

  Slot copyWith({
    bool? status,
    String? message,
    List<SlotData>? data,
  }) =>
      Slot(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  List<SlotData>? get data => _data;

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

class SlotData {
  SlotData({
    num? id,
    num? salonId,
    String? time,
    num? weekday,
    num? bookingLimit,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _salonId = salonId;
    _time = time;
    _weekday = weekday;
    _bookingLimit = bookingLimit;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  SlotData.fromJson(dynamic json) {
    _id = json['id'];
    _salonId = num.tryParse(json['salon_id'].toString());
    _time = json['time'];
    _weekday = num.tryParse(json['weekday'].toString());
    _bookingLimit = num.tryParse(json['booking_limit'].toString());
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  num? _salonId;
  String? _time;
  num? _weekday;
  num? _bookingLimit;
  String? _createdAt;
  String? _updatedAt;

  SlotData copyWith({
    num? id,
    num? salonId,
    String? time,
    num? weekday,
    num? bookingLimit,
    String? createdAt,
    String? updatedAt,
  }) =>
      SlotData(
        id: id ?? _id,
        salonId: salonId ?? _salonId,
        time: time ?? _time,
        weekday: weekday ?? _weekday,
        bookingLimit: bookingLimit ?? _bookingLimit,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get salonId => _salonId;

  String? get time => _time;

  num? get weekday => _weekday;

  num? get bookingLimit => _bookingLimit;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['salon_id'] = _salonId;
    map['time'] = _time;
    map['weekday'] = _weekday;
    map['booking_limit'] = _bookingLimit;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
