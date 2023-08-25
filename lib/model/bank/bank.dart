class BankAccount {
  BankAccount({
    int? id,
    int? salonId,
    String? bankTitle,
    String? accountNumber,
    String? holder,
    String? swiftCode,
    String? chequePhoto,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _salonId = salonId;
    _bankTitle = bankTitle;
    _accountNumber = accountNumber;
    _holder = holder;
    _swiftCode = swiftCode;
    _chequePhoto = chequePhoto;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  BankAccount.fromJson(dynamic json) {
    _id = json['id'];
    _salonId = int.tryParse(json['salon_id'].toString());
    _bankTitle = json['bank_title'];
    _accountNumber = json['account_number'];
    _holder = json['holder'];
    _swiftCode = json['swift_code'];
    _chequePhoto = json['cheque_photo'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  int? _salonId;
  String? _bankTitle;
  String? _accountNumber;
  String? _holder;
  String? _swiftCode;
  String? _chequePhoto;
  String? _createdAt;
  String? _updatedAt;

  BankAccount copyWith({
    int? id,
    int? salonId,
    String? bankTitle,
    String? accountNumber,
    String? holder,
    String? swiftCode,
    String? chequePhoto,
    String? createdAt,
    String? updatedAt,
  }) =>
      BankAccount(
        id: id ?? _id,
        salonId: salonId ?? _salonId,
        bankTitle: bankTitle ?? _bankTitle,
        accountNumber: accountNumber ?? _accountNumber,
        holder: holder ?? _holder,
        swiftCode: swiftCode ?? _swiftCode,
        chequePhoto: chequePhoto ?? _chequePhoto,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  int? get id => _id;

  int? get salonId => _salonId;

  String? get bankTitle => _bankTitle;

  String? get accountNumber => _accountNumber;

  String? get holder => _holder;

  String? get swiftCode => _swiftCode;

  String? get chequePhoto => _chequePhoto;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['salon_id'] = _salonId;
    map['bank_title'] = _bankTitle;
    map['account_number'] = _accountNumber;
    map['holder'] = _holder;
    map['swift_code'] = _swiftCode;
    map['cheque_photo'] = _chequePhoto;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
