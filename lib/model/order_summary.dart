import 'package:cutfx_salon/model/user/salon.dart';

class OrderSummary {
  OrderSummary({
    num? serviceAmount,
    num? discountAmount,
    num? subtotal,
    num? totalTaxAmount,
    num? payableAmount,
    num? couponApply,
    CouponData? coupon,
    List<Taxes>? taxes,
    List<Services>? services,
  }) {
    _serviceAmount = serviceAmount;
    _discountAmount = discountAmount;
    _subtotal = subtotal;
    _totalTaxAmount = totalTaxAmount;
    _payableAmount = payableAmount;
    _couponApply = couponApply;
    _coupon = coupon;
    _taxes = taxes;
    _services = services;
  }

  OrderSummary.fromJson(dynamic json) {
    _serviceAmount = json['service_amount'];
    _discountAmount = json['discount_amount'];
    _subtotal = json['subtotal'];
    _totalTaxAmount = json['total_tax_amount'];
    _payableAmount = json['payable_amount'];
    _couponApply = json['coupon_apply'];
    if (json['coupon'] != null) {
      _coupon =
          json['coupon'] != null ? CouponData.fromJson(json['coupon']) : null;
    }
    if (json['taxes'] != null) {
      _taxes = [];
      json['taxes'].forEach((v) {
        _taxes?.add(Taxes.fromJson(v));
      });
    }
    if (json['services'] != null) {
      _services = [];
      json['services'].forEach((v) {
        _services?.add(Services.fromJson(v));
      });
    }
  }

  num? _serviceAmount;
  num? _discountAmount;
  num? _subtotal;
  num? _totalTaxAmount;
  num? _payableAmount;
  num? _couponApply;
  CouponData? _coupon;
  List<Taxes>? _taxes;
  List<Services>? _services;

  OrderSummary copyWith({
    num? serviceAmount,
    num? discountAmount,
    num? subtotal,
    num? totalTaxAmount,
    num? payableAmount,
    num? couponApply,
    CouponData? coupon,
    List<Taxes>? taxes,
    List<Services>? services,
  }) =>
      OrderSummary(
        serviceAmount: serviceAmount ?? _serviceAmount,
        discountAmount: discountAmount ?? _discountAmount,
        subtotal: subtotal ?? _subtotal,
        totalTaxAmount: totalTaxAmount ?? _totalTaxAmount,
        payableAmount: payableAmount ?? _payableAmount,
        couponApply: couponApply ?? _couponApply,
        coupon: coupon ?? _coupon,
        taxes: taxes ?? _taxes,
        services: services ?? _services,
      );

  num? get serviceAmount => _serviceAmount;

  num? get discountAmount => _discountAmount;

  num? get subtotal => _subtotal;

  num? get totalTaxAmount => _totalTaxAmount;

  num? get payableAmount => _payableAmount;

  num? get couponApply => _couponApply;

  CouponData? get coupon => _coupon;

  List<Taxes>? get taxes => _taxes;

  List<Services>? get services => _services;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_amount'] = _serviceAmount;
    map['discount_amount'] = _discountAmount;
    map['subtotal'] = _subtotal;
    map['total_tax_amount'] = _totalTaxAmount;
    map['payable_amount'] = _payableAmount;
    map['coupon_apply'] = _couponApply;
    if (_coupon != null) {
      map['coupon'] = _coupon?.toJson();
    }
    if (_taxes != null) {
      map['taxes'] = _taxes?.map((v) => v.toJson()).toList();
    }
    if (_services != null) {
      map['services'] = _services?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CouponData {
  CouponData({
    num? id,
    String? coupon,
    num? percentage,
    num? maxDiscountAmount,
    num? minOrderAmount,
    String? heading,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _coupon = coupon;
    _percentage = percentage;
    _maxDiscountAmount = maxDiscountAmount;
    _minOrderAmount = minOrderAmount;
    _heading = heading;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  CouponData.fromJson(dynamic json) {
    _id = json['id'];
    _coupon = json['coupon'];
    _percentage = json['percentage'];
    _maxDiscountAmount = json['max_discount_amount'];
    _minOrderAmount = json['min_order_amount'];
    _heading = json['heading'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  String? _coupon;
  num? _percentage;
  num? _maxDiscountAmount;
  num? _minOrderAmount;
  String? _heading;
  String? _description;
  String? _createdAt;
  String? _updatedAt;

  CouponData copyWith({
    num? id,
    String? coupon,
    num? percentage,
    num? maxDiscountAmount,
    num? minOrderAmount,
    String? heading,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) =>
      CouponData(
        id: id ?? _id,
        coupon: coupon ?? _coupon,
        percentage: percentage ?? _percentage,
        maxDiscountAmount: maxDiscountAmount ?? _maxDiscountAmount,
        minOrderAmount: minOrderAmount ?? _minOrderAmount,
        heading: heading ?? _heading,
        description: description ?? _description,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  String? get coupon => _coupon;

  num? get percentage => _percentage;

  num? get maxDiscountAmount => _maxDiscountAmount;

  num? get minOrderAmount => _minOrderAmount;

  String? get heading => _heading;

  String? get description => _description;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['coupon'] = _coupon;
    map['percentage'] = _percentage;
    map['max_discount_amount'] = _maxDiscountAmount;
    map['min_order_amount'] = _minOrderAmount;
    map['heading'] = _heading;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Taxes {
  Taxes({
    num? id,
    num? status,
    String? taxTitle,
    num? type,
    num? value,
    num? taxAmount,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _status = status;
    _taxTitle = taxTitle;
    _type = type;
    _value = value;
    _taxAmount = taxAmount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Taxes.fromJson(dynamic json) {
    _id = json['id'];
    _status = json['status'];
    _taxTitle = json['tax_title'];
    _type = json['type'];
    _value = json['value'];
    _taxAmount = json['tax_amount'];

    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  num? _status;
  String? _taxTitle;
  num? _type;
  num? _value;
  num? _taxAmount;
  String? _createdAt;
  String? _updatedAt;

  Taxes copyWith({
    num? id,
    num? status,
    String? taxTitle,
    num? type,
    num? value,
    num? taxAmount,
    String? createdAt,
    String? updatedAt,
  }) =>
      Taxes(
        id: id ?? _id,
        status: status ?? _status,
        taxTitle: taxTitle ?? _taxTitle,
        type: type ?? _type,
        value: value ?? _value,
        taxAmount: taxAmount ?? _taxAmount,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get status => _status;

  String? get taxTitle => _taxTitle;

  num? get type => _type;

  num? get value => _value;

  num? get taxAmount => _taxAmount;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['status'] = _status;
    map['tax_title'] = _taxTitle;
    map['type'] = _type;
    map['value'] = _value;
    map['tax_amount'] = _taxAmount;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
