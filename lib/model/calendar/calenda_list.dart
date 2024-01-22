import 'dart:convert';

import 'package:cutfx_salon/model/calendar/calendar_date.dart';

class CalendarList {
  List<CalendarDates>? date;

  CalendarList({this.date});

  CalendarList.fromJson(Map<String, dynamic> json) {
    date = json['date'].forEach((v) {
      date!.add(CalendarDates.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    return data;
  }

  static Map<String, dynamic> toMap(CalendarList dates) => {
        'date': dates.date,
      };

  static String encode(List<CalendarList> dates) => json.encode(
        dates
            .map<Map<String, dynamic>>((item) => CalendarList.toMap(item))
            .toList(),
      );

  static List<Object> decode(String dates) {
    if (dates.isNotEmpty) {
      return (json.decode(dates) as List<dynamic>)
          .map<CalendarList>((item) => CalendarList.fromJson(item))
          .toList();
    }
    return [];
  }
}
