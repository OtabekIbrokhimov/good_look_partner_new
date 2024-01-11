import 'package:cutfx_salon/model/calendar/calendar_date.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../model/calendar/calenda_list.dart';

part 'add_master_time_event.dart';

part 'add_master_time_state.dart';

class AddMasterTimeBlock extends Bloc<AddServiceEvent, AddMasterTimeState> {
  AddMasterTimeBlock() : super(AddTimeStateInitial()) {
    if (Get.arguments != null) {
      isAdd = Get.arguments['isAdd'];
      pickTimes(Get.arguments['list']);
    }
    on<AddTimeEvent>((event, emit) {
      emit(AddTimeState());
    });

    on<UpdateTimeEvent>((event, emit) {
      emit(UpdateTimeState());
    });
  }
  bool isAdd = false;
  bool isFirstTime = true;
  String startTime = "00:00";
  String endTime = "00:00";
  CalendarList? calendarDates;
  List<DateTime?> datas = [];
  CalendarList? oldDates;
  List<DateTime?> dataForCheck = [];
  void takeTime(List<DateTime?> data) {
    for (int i = 0; i < dataForCheck.length; i++) {
      for (int r = 0; r < data.length; r++) {
        if (dataForCheck[i].toString().split(' ').first ==
            data[r].toString().split(' ').first) {
          data.removeAt(r);
          // Get.log(dataForCheck.toString());
          // Get.log(data.toString());
          // Get.log(
          //     "${dataForCheck[i].toString().split(' ').first} == ${data[r].toString().split(' ').first}");
          // AppRes.showSnackBar("You can not select this time more", false);
          // return;
        }
      }
    }
    datas = data;
    add(AddTimeEvent());
  }

  void takeDateTime() {
    if (isAdd) {
      oldDates = calendarDates;
    }
    int l = calendarDates?.date?.length ?? 0;
    for (int i = 0; i < l; i++) {
      if (isAdd) {
        dataForCheck.add(DateTime.parse(calendarDates?.date?[i].date ?? ""));
      } else {
        datas.add(DateTime.parse(calendarDates?.date?[i].date ?? ""));
      }
      if (i == 0) {
        startTime = calendarDates?.date?[i].start ?? "00:00";
        endTime = calendarDates?.date?[i].end ?? "00:00";
      }
    }

    Get.log("${datas}mana");
  }

  void pickTimes(CalendarList data) {
    if (isFirstTime == true) {
      calendarDates = data;
      isFirstTime = false;
      takeDateTime();
    }
  }

  void saveTime() async {
    if (isAdd == false) {
      oldDates?.date?.clear();
    }
    Get.log(datas.toString());
    List<CalendarDates> list = [];
    for (int i = 0; i < datas.length; i++) {
      list.add(CalendarDates(
          date: datas[i].toString().split(" ").first,
          start: startTime,
          end: endTime));
      add(AddTimeEvent());
    }
    int l = oldDates?.date?.length ?? 0;
    for (int n = 0; n < l; n++) {
      for (int i = 0; i < list.length; i++) {
        if (oldDates?.date?[n].date == list[i].date) {
          list.removeAt(i);
          break;
        }
      }
    }
    CalendarList listt = CalendarList(date: list);
    if (list.isNotEmpty) {
      Get.back(result: listt);
    } else {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseSelectTime, false);
    }
  }

  void selectTime(DateTime time, bool isStart) {
    if (isStart == true) {
      startTime =
          '${formatTime(time.hour.toString())}:${formatTime(time.minute.toString())}';
      Get.log("mana $endTime");
    } else {
      endTime =
          '${formatTime(time.hour.toString())}:${formatTime(time.minute.toString())}';
      Get.log("mana $startTime");
    }
    add(AddTimeEvent());
    Get.log('${time.hour.toString()}:${time.minute.toString()}');
  }

  String formatTime(String value) {
    if (value.length > 1) {
      return value;
    } else {
      return "0$value";
    }
  }
}
