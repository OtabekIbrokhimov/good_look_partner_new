import 'package:cutfx_salon/model/calendar/calendar_date.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../utils/shared_pref.dart';

part 'add_master_time_event.dart';
part 'add_master_time_state.dart';

class AddMasterTimeBlock extends Bloc<AddTimeEvent, AddMasterTimeState> {
  AddMasterTimeBlock() : super(AddTimeStateInitial()) {
    on<AddTimeEvent>((event, emit) {
      emit(AddTimeState());
    });
  }

  bool isFirstTime = true;
  String startTime = "00:00";
  String endTime = "00:00";
  List<CalendarDates> calendarDates = [];
  List<CalendarDates> calendarDates2 = [];
  List<DateTime?> datas = [];

  void takeTime(List<DateTime?> data) {
    datas = data;
    add(AddTimeEvent());
  }

  void takeDateTime() {
    for (int i = 0; i < calendarDates.length; i++) {
      datas.add(DateTime.parse(calendarDates[i].date ?? ""));
      if (i == 0) {
        startTime = calendarDates[i].start ?? "00:00";
        endTime = calendarDates[i].start ?? "00:00";
      }
    }

    Get.log(datas.toString());
    add(AddTimeEvent());
  }

  void pickTimes(List<CalendarDates> data) {
    if (isFirstTime == true) {
      calendarDates = data;
      isFirstTime = false;
      takeDateTime();
      add(AddTimeEvent());
    }
  }

  void saveTime() async {
    SharePref sharePref = await SharePref().init();
    for (int i = 0; i < datas.length; i++) {
      calendarDates2.add(CalendarDates(
          date: datas[i].toString().split(" ").first,
          start: startTime,
          end: endTime));
      calendarDates = calendarDates2;
      sharePref.saveString(
          AppRes.calendarDates, CalendarDates.encode(calendarDates));
      final String dateString = sharePref.getString(AppRes.calendarDates) ?? "";
      Get.log("${dateString}saqlandi mana");
    }

    add(AddTimeEvent());
    Get.back();
    // Get.back(result: calendarDates);
  }

  Future<void> selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext? context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (isStart == true) {
        startTime = '${picked.hour}:${picked.minute}';
      } else {
        endTime = '${picked.hour}:${picked.minute}';
      }
      add(AddTimeEvent());
      Get.log('${picked.hour}:${picked.minute}');
    }
  }
}
