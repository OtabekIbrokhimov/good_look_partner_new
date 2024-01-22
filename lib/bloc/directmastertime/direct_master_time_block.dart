import 'dart:convert';

import 'package:cutfx_salon/model/calendar/CalendarMainList.dart';
import 'package:cutfx_salon/model/calendar/calenda_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../model/calendar/calendar_date.dart';
import '../../screens/add_master/calendar_screen.dart';
import '../../utils/app_res.dart';
import '../../utils/shared_pref.dart';

part 'direct_master_time_event.dart';
part 'direct_master_time_state.dart';

class DirectMasterBlock extends Bloc<DirectMasterEvent, DirectMasterTimeState> {
  DirectMasterBlock() : super(DirectMasterStateInitial()) {
    forRememberOldTimes(Get.arguments);
    on<DirectMasterAddTimeEvent>((event, emit) {
      emit(DirectMasterAddTimeState());
    });
    add(DirectMasterAddTimeEvent());
  }

  List<DateTime> time = [];
  CalendarList? dates;
  CalendarMainList mainList = CalendarMainList(date: []);
  CalendarMainList allInfo = CalendarMainList(date: []);
  bool needReload = true;

  void takeTimeForResult(CalendarList dateList, bool needUpdate) async {
    CalendarMainList mainListInternal = CalendarMainList(date: []);
    mainListInternal.date?.addAll([dateList]);
    Get.log("ikkalasi");
    bool needAdd = true;
    SharePref sharePref = await SharePref().init();
    String dateString = sharePref.getString(AppRes.calendarDates) ?? "";
    if (dateString.isEmpty) {
      sharePref.saveString(AppRes.calendarDates, jsonEncode(mainListInternal));
      dateString = sharePref.getString(AppRes.calendarDates) ?? "";
      needAdd = false;
    }
    Get.log("${dateString}bu ush saqlangan");
    Map valueMap = json.decode(dateString);
    for (int b = 0; b < valueMap['date'].length; b++) {
      CalendarList calendarList = CalendarList(date: []);
      for (int i = 0; i < valueMap['date'][b]['date'].length; i++) {
        calendarList.date?.add(CalendarDates(
            start: valueMap['date'][b]['date'][i]['start'],
            end: valueMap['date'][b]['date'][i]['end'],
            date: valueMap['date'][b]['date'][i]['date']));
      }
      if (calendarList.date?.isNotEmpty ?? false) {
        allInfo.date?.add(calendarList);
      }
    }
    List<CalendarList> list2 = mainListInternal.date ?? [];
    if (needAdd == true) allInfo.date?.addAll(list2);
    sharePref.saveString(AppRes.calendarDates, jsonEncode(allInfo));
    Get.log("saqladi +  ??  + ${mainList.toJson().toString()}plplp");
    mainList = allInfo;
    Get.log("saqladi +  ??  + ${mainList.date?[0].toJson().toString()}plp");
    add(DirectMasterAddTimeEvent());
  }

  void forRememberOldTimes(List<CalendarDates> calendarDates) async {
    CalendarList calendarList = CalendarList(date: calendarDates);
    mainList.date?.add(calendarList);
  }

  void getToCalendar() async {
    Get.log("add bir marta ishladi");
    CalendarList sortDates = CalendarList(date: []);
    int l = mainList.date?.length ?? 0;
    for (int b = 0; b < l; b++) {
      sortDates.date?.addAll(mainList.date?[b].date ?? []);
    }
    Get.log("${sortDates}mana bor ma'lumot");
    add(DirectMasterAddTimeEvent());
    CalendarList? dateList = await Get.to(() => const CalendarScreen(),
        arguments: {"list": sortDates, "isAdd": true});
    if (dateList != null) {
      Get.log(dateList.toString());
      takeTimeForResult(dateList, true);
    }
  }

  void edit(int index) async {
    Get.log("edit bir marta ishladi");
    CalendarList? dateList = await Get.to(() => const CalendarScreen(),
        arguments: {"list": mainList.date?[index], "isAdd": false});
    if (dateList != null) {
      Get.log("${dateList.date} --- result");
      deleteDay(index, isEdit: true);
      takeTimeForResult(dateList, false);
    }
    add(DirectMasterAddTimeEvent());
  }

  void deleteDay(int index, {bool isEdit = false}) async {
    SharePref sharePref = await SharePref().init();
    mainList.date?.removeAt(index);
    sharePref.saveString(AppRes.calendarDates, jsonEncode(mainList));
    add(DirectMasterAddTimeEvent());
    isEdit ? {} : Get.back();
  }
}
