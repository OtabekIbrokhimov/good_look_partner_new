class GetPath {
  GetPath({
    bool? status,
    String? message,
    String? path,
  }) {
    _status = status;
    _message = message;
    _path = path;
  }

  GetPath.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _path = json['path'];
  }

  bool? _status;
  String? _message;
  String? _path;

  GetPath copyWith({
    bool? status,
    String? message,
    String? path,
  }) =>
      GetPath(
        status: status ?? _status,
        message: message ?? _message,
        path: path ?? _path,
      );

  bool? get status => _status;

  String? get message => _message;

  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['path'] = _path;
    return map;
  }
}
