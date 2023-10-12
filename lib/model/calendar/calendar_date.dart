import 'dart:convert';

class CalendarDates {
  String? date;
  String? start;
  String? end;

  CalendarDates({this.date, this.start, this.end});

  CalendarDates.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['start'] = start;
    data['end'] = end;
    return data;
  }

  static Map<String, dynamic> toMap(CalendarDates dates) => {
        'date': dates.date,
        'start': dates.start,
        'end': dates.end,
      };

  static String encode(List<CalendarDates> dates) => json.encode(
        dates
            .map<Map<String, dynamic>>((item) => CalendarDates.toMap(item))
            .toList(),
      );

  static List<CalendarDates> decode(String dates) {
    if (dates.isNotEmpty) {
      return (json.decode(dates) as List<dynamic>)
          .map<CalendarDates>((item) => CalendarDates.fromJson(item))
          .toList();
    }
    return [];
  }
}
