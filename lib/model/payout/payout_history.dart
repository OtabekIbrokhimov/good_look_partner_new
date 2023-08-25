class PayoutHistory {
  PayoutHistory({
    bool? status,
    String? message,
    List<PayoutHistoryData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  PayoutHistory.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(PayoutHistoryData.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<PayoutHistoryData>? _data;

  PayoutHistory copyWith({
    bool? status,
    String? message,
    List<PayoutHistoryData>? data,
  }) =>
      PayoutHistory(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  List<PayoutHistoryData>? get data => _data;

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

class PayoutHistoryData {
  PayoutHistoryData({
    num? id,
    String? requestNumber,
    num? status,
    num? salonId,
    num? amount,
    String? summary,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _requestNumber = requestNumber;
    _status = status;
    _salonId = salonId;
    _amount = amount;
    _summary = summary;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  PayoutHistoryData.fromJson(dynamic json) {
    _id = json['id'];
    _requestNumber = json['request_number'];
    _status = json['status'];
    _salonId = json['salon_id'];
    _amount = json['amount'];
    _summary = json['summary'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  String? _requestNumber;
  num? _status;
  num? _salonId;
  num? _amount;
  String? _summary;
  String? _createdAt;
  String? _updatedAt;

  PayoutHistoryData copyWith({
    num? id,
    String? requestNumber,
    num? status,
    num? salonId,
    num? amount,
    String? summary,
    String? createdAt,
    String? updatedAt,
  }) =>
      PayoutHistoryData(
        id: id ?? _id,
        requestNumber: requestNumber ?? _requestNumber,
        status: status ?? _status,
        salonId: salonId ?? _salonId,
        amount: amount ?? _amount,
        summary: summary ?? _summary,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  String? get requestNumber => _requestNumber;

  num? get status => _status;

  num? get salonId => _salonId;

  num? get amount => _amount;

  String? get summary => _summary;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['request_number'] = _requestNumber;
    map['status'] = _status;
    map['salon_id'] = _salonId;
    map['amount'] = _amount;
    map['summary'] = _summary;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
