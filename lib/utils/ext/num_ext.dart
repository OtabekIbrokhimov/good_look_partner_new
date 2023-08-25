import 'package:cutfx_salon/utils/app_res.dart';
import 'package:intl/intl.dart';

extension NumExt on num {
  String get currency {
    var format = NumberFormat("###,### ${AppRes.currency}");
    return format.format(this).replaceAll(',', ' ');
  }
}
