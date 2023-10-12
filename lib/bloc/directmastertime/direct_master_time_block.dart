import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/calendar/calendar_date.dart';
import '../../utils/app_res.dart';
import '../../utils/shared_pref.dart';

part 'direct_master_time_event.dart';part 'direct_master_time_state.dart';

class DirectMasterBlock extends Bloc<DirectMasterEvent, DirectMasterTimeState> {
  DirectMasterBlock() : super(DirectMasterStateInitial()) {
    takeAllInformation();
    on<DirectMasterAddTimeEvent>((event, emit) {
      emit(DirectMasterAddTimeState());
    });
  }

  List<DateTime> time = [];
  List<CalendarDates> dates = [];

  void takeAllInformation() async {
    SharePref sharePref = await SharePref().init();
    final String dateString = sharePref.getString(AppRes.calendarDates) ?? "";
    if (CalendarDates.decode(dateString).isNotEmpty) {
      dates = CalendarDates.decode(dateString);
    }
    add(DirectMasterAddTimeEvent());
  }

  void deleteDay(int index) async {
    SharePref sharePref = await SharePref().init();
    dates.removeAt(index);
    sharePref.saveString(AppRes.calendarDates, "");
    sharePref.saveString(AppRes.calendarDates, CalendarDates.encode(dates));
    add(DirectMasterAddTimeEvent());
  }
}
