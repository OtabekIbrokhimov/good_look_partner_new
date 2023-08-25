/// status : true
/// message : "Data fetch successfully"
/// data : [{"id":3,"title":"Orders","created_at":"2023-01-13T10:11:01.000000Z","updated_at":"2023-01-13T10:11:01.000000Z","faqs":[{"id":5,"category_id":3,"question":"114 In cases like this","answer":"Not a big fan of changing globally the textarea css attr.\r\n\r\nWould rather use a specific css class, but it could be overriden by some other classes, so you could use the !important, even th","created_at":"2023-01-13T10:28:26.000000Z","updated_at":"2023-01-13T10:51:13.000000Z"}]}]

class Faqs {
  Faqs({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  Faqs.fromJson(dynamic json) {
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

  Faqs copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      Faqs(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  List<Data>? get data => _data;

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

/// id : 3
/// title : "Orders"
/// created_at : "2023-01-13T10:11:01.000000Z"
/// updated_at : "2023-01-13T10:11:01.000000Z"
/// faqs : [{"id":5,"category_id":3,"question":"114 In cases like this","answer":"Not a big fan of changing globally the textarea css attr.\r\n\r\nWould rather use a specific css class, but it could be overriden by some other classes, so you could use the !important, even th","created_at":"2023-01-13T10:28:26.000000Z","updated_at":"2023-01-13T10:51:13.000000Z"}]

class Data {
  Data({
    num? id,
    String? title,
    String? createdAt,
    String? updatedAt,
    List<FaqData>? faqs,
  }) {
    _id = id;
    _title = title;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _faqs = faqs;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['faqs'] != null) {
      _faqs = [];
      json['faqs'].forEach((v) {
        _faqs?.add(FaqData.fromJson(v));
      });
    }
  }

  num? _id;
  String? _title;
  String? _createdAt;
  String? _updatedAt;
  List<FaqData>? _faqs;

  Data copyWith({
    num? id,
    String? title,
    String? createdAt,
    String? updatedAt,
    List<FaqData>? faqs,
  }) =>
      Data(
        id: id ?? _id,
        title: title ?? _title,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        faqs: faqs ?? _faqs,
      );

  num? get id => _id;

  String? get title => _title;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  List<FaqData>? get faqs => _faqs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_faqs != null) {
      map['faqs'] = _faqs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 5
/// category_id : 3
/// question : "114 In cases like this"
/// answer : "Not a big fan of changing globally the textarea css attr.\r\n\r\nWould rather use a specific css class, but it could be overriden by some other classes, so you could use the !important, even th"
/// created_at : "2023-01-13T10:28:26.000000Z"
/// updated_at : "2023-01-13T10:51:13.000000Z"

class FaqData {
  FaqData({
    num? id,
    num? categoryId,
    String? question,
    String? answer,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _categoryId = categoryId;
    _question = question;
    _answer = answer;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  FaqData.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _question = json['question'];
    _answer = json['answer'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  num? _categoryId;
  String? _question;
  String? _answer;
  String? _createdAt;
  String? _updatedAt;

  FaqData copyWith({
    num? id,
    num? categoryId,
    String? question,
    String? answer,
    String? createdAt,
    String? updatedAt,
  }) =>
      FaqData(
        id: id ?? _id,
        categoryId: categoryId ?? _categoryId,
        question: question ?? _question,
        answer: answer ?? _answer,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get categoryId => _categoryId;

  String? get question => _question;

  String? get answer => _answer;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['question'] = _question;
    map['answer'] = _answer;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
