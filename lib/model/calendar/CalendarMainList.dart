import 'dart:convert';

import 'calenda_list.dart';
class CalendarMainList {
  List<CalendarList>? date;

  CalendarMainList({this.date});

  CalendarMainList.fromJson(Map<String, dynamic> json) {
    date = json['date'].forEach((v) {
      date?.add(CalendarList.fromJson(v));
    }
    );}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    return data;
  }

  static Map<String, dynamic> toMap(CalendarMainList dates) => {
    'date': dates.date,
  };


  static String encode(List<CalendarMainList> dates) => json.encode(
    dates
        .map<Map<String, dynamic>>((item) => CalendarMainList.toMap(item))
        .toList(),
  );

  static List<CalendarMainList> decode(String dates) {
    if (dates.isNotEmpty) {
      return (json.decode(dates) as List<dynamic>)
          .map<CalendarMainList>((item) => CalendarMainList.fromJson(item))
          .toList();
    }
    return [];
  }
}