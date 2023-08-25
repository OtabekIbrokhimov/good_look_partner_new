class WalletStatement {
  WalletStatement({
    bool? status,
    String? message,
    List<WalletStatementData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  WalletStatement.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(WalletStatementData.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<WalletStatementData>? _data;

  WalletStatement copyWith({
    bool? status,
    String? message,
    List<WalletStatementData>? data,
  }) =>
      WalletStatement(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  List<WalletStatementData>? get data => _data;

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

class WalletStatementData {
  WalletStatementData({
    num? id,
    num? salonId,
    String? transactionId,
    dynamic bookingId,
    num? type,
    num? amount,
    num? crOrDr,
    String? summary,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _salonId = salonId;
    _transactionId = transactionId;
    _bookingId = bookingId;
    _type = type;
    _amount = amount;
    _crOrDr = crOrDr;
    _summary = summary;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  WalletStatementData.fromJson(dynamic json) {
    _id = json['id'];
    _salonId = json['salon_id'];
    _transactionId = json['transaction_id'];
    _bookingId = json['booking_id'];
    _type = json['type'];
    _amount = json['amount'];
    _crOrDr = json['cr_or_dr'];
    _summary = json['summary'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  num? _salonId;
  String? _transactionId;
  dynamic _bookingId;
  num? _type;
  num? _amount;
  num? _crOrDr;
  String? _summary;
  String? _createdAt;
  String? _updatedAt;

  WalletStatementData copyWith({
    num? id,
    num? salonId,
    String? transactionId,
    dynamic bookingId,
    num? type,
    num? amount,
    num? crOrDr,
    String? summary,
    String? createdAt,
    String? updatedAt,
  }) =>
      WalletStatementData(
        id: id ?? _id,
        salonId: salonId ?? _salonId,
        transactionId: transactionId ?? _transactionId,
        bookingId: bookingId ?? _bookingId,
        type: type ?? _type,
        amount: amount ?? _amount,
        crOrDr: crOrDr ?? _crOrDr,
        summary: summary ?? _summary,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get salonId => _salonId;

  String? get transactionId => _transactionId;

  dynamic get bookingId => _bookingId;

  num? get type => _type;

  num? get amount => _amount;

  num? get crOrDr => _crOrDr;

  String? get summary => _summary;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['salon_id'] = _salonId;
    map['transaction_id'] = _transactionId;
    map['booking_id'] = _bookingId;
    map['type'] = _type;
    map['amount'] = _amount;
    map['cr_or_dr'] = _crOrDr;
    map['summary'] = _summary;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
