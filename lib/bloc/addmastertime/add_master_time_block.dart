import 'package:cutfx_salon/model/calendar/calendar_date.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../model/calendar/calenda_list.dart';
import '../../screens/add_master/add_time_screen.dart';
import '../../utils/shared_pref.dart';

part 'add_master_time_event.dart';
part 'add_master_time_state.dart';

class AddMasterTimeBlock extends Bloc<AddServiceEvent, AddMasterTimeState> {
  AddMasterTimeBlock() : super(AddTimeStateInitial()) {
    if (Get.arguments != null) {
      pickTimes(Get.arguments);
    }
    on<AddTimeEvent>((event, emit) {
      emit(AddTimeState());
    });

    on<UpdateTimeEvent>((event, emit) {
      emit(UpdateTimeState());
    });
  }

  bool isFirstTime = true;
  String startTime = "00:00";
  String endTime = "00:00";
  CalendarList? calendarDates;
  List<DateTime?> datas = [];
  List<DateTime?> dataForCheck = [];

  void takeTime(List<DateTime?> data) {
    datas = data;
    add(AddTimeEvent());
  }

  void takeDateTime() {
    int l =  calendarDates?.date?.length??0;
    for (int i = 0; i <l; i++) {
      datas.add(DateTime.parse(calendarDates?.date?[i].date ?? ""));
      if (i == 0) {
        startTime = calendarDates?.date?[i].start ?? "00:00";
        endTime = calendarDates?.date?[i].start ?? "00:00";
      }
    }

    Get.log(datas.toString() + "mana");
  }

  void pickTimes(CalendarList data) {
    if (isFirstTime == true) {
      calendarDates = data;
      isFirstTime = false;
      takeDateTime();
    }
  }

  void saveTime() async {
    Get.log(datas.toString());
    List<CalendarDates> list =[];
    for (int i = 0; i < datas.length; i++) {
      list.add(CalendarDates(
          date: datas[i].toString().split(" ").first,
          start: startTime,
          end: endTime));
      add(AddTimeEvent());
    }
    CalendarList listt = CalendarList(date: list);
    if(list.isNotEmpty) {
      Get.log("${listt.date?[0].start}mana");
      Get.off(() => const AddTimeScreen(), arguments: listt);
    }else{
      AppRes.showSnackBar("please choose the date", false);
    }
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
        Get.log("mana $endTime");
      } else {
        endTime = '${picked.hour}:${picked.minute}';
        Get.log("mana $startTime");
      }
      add(AddTimeEvent());
      Get.log('${picked.hour}:${picked.minute}');
    }
  }
}
