class SendOtp {
  SendOtp({
    String? userType,
    String? phoneNumber,

  }) {
    _userType = userType;
    _phoneNumber = phoneNumber;

  }

  SendOtp.fromJson(dynamic json) {
    _userType = json['user_type'];
    _phoneNumber = json['phone_number'];

  }

  String? _userType;
  String? _phoneNumber;


  SendOtp copyWith({
    String? userType,
    String? phoneNumber,

  }) =>
      SendOtp(
        userType: userType ?? _userType,
        phoneNumber: phoneNumber ?? _phoneNumber,

      );

  String? get userType => _userType;

  String? get phoneNumber => _phoneNumber;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_type'] = _userType;
    map['phone_number'] = _phoneNumber;
    return map;
  }
}
