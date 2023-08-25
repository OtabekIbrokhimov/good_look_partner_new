class EarningHistory {
  EarningHistory({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  EarningHistory.fromJson(dynamic json) {
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

  EarningHistory copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      EarningHistory(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  List<Data>? get data => _data;

  int totalEarning() {
    int earning = 0;
    for (Data data in data ?? []) {
      earning = earning + data.amount!.toInt();
    }
    return earning;
  }

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
    num? salonId,
    num? bookingId,
    String? earningNumber,
    num? amount,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _salonId = salonId;
    _bookingId = bookingId;
    _earningNumber = earningNumber;
    _amount = amount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _salonId = json['salon_id'];
    _bookingId = json['booking_id'];
    _earningNumber = json['earning_number'];
    _amount = json['amount'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  num? _salonId;
  num? _bookingId;
  String? _earningNumber;
  num? _amount;
  String? _createdAt;
  String? _updatedAt;

  Data copyWith({
    num? id,
    num? salonId,
    num? bookingId,
    String? earningNumber,
    num? amount,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        salonId: salonId ?? _salonId,
        bookingId: bookingId ?? _bookingId,
        earningNumber: earningNumber ?? _earningNumber,
        amount: amount ?? _amount,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get salonId => _salonId;

  num? get bookingId => _bookingId;

  String? get earningNumber => _earningNumber;

  num? get amount => _amount;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['salon_id'] = _salonId;
    map['booking_id'] = _bookingId;
    map['earning_number'] = _earningNumber;
    map['amount'] = _amount;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
