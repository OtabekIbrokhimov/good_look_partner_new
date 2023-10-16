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
    if (Get.arguments != null) {
      CalendarList dateList = Get.arguments;
      mainList.date?.addAll([dateList]);
      takeTimeForResult(mainList);
    } else {
      forRememberOldTimes();
    }

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

  void takeTimeForResult(CalendarMainList list) async {
    SharePref sharePref = await SharePref().init();
    String dateString = sharePref.getString(AppRes.calendarDates) ?? "";
    if (dateString.isEmpty) {
      sharePref.saveString(AppRes.calendarDates, jsonEncode(list));
      dateString = sharePref.getString(AppRes.calendarDates) ?? "";
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
    List<CalendarList> list2 = list.date ?? [];
    allInfo.date?.addAll(list2);
    sharePref.saveString(AppRes.calendarDates, jsonEncode(allInfo));
    mainList = allInfo;
    Get.log("${allInfo.date?[0].date?[0].start.toString()} ol toy");
  }

  void forRememberOldTimes() async {
    Get.log('ishladi');
    if (mainList.date!.isEmpty) {
      SharePref sharePref = await SharePref().init();
      String dateString = sharePref.getString(AppRes.calendarDates) ?? "";
      if (dateString.isNotEmpty) {
        Map valueMap = json.decode(dateString);
        Get.log("${valueMap['date'][0]['date']}bu list");
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
        sharePref.saveString(AppRes.calendarDates, jsonEncode(allInfo));
        mainList = allInfo;
        Get.log("${allInfo.date?[0].date?[0].start.toString()} ol toy");
      } else {
        return;
      }
    } else {
      return;
    }
  }

  void getToCalendar() {
    CalendarList sortDates = CalendarList(date: []);
    int l = allInfo.date?.length ?? 0;
    for (int b = 0; b < l; b++) {
      sortDates.date?.addAll(allInfo.date?[b].date ?? []);
    }
    Get.log("${sortDates}mana bor ma'lumot");
    add(DirectMasterAddTimeEvent());
    Get.off(() => const CalendarScreen(), arguments: sortDates);
  }

  void deleteDay(int index, {bool isEdit = false}) async {
    SharePref sharePref = await SharePref().init();
    allInfo.date?.removeAt(index);
    mainList = allInfo;
    sharePref.saveString(AppRes.calendarDates, jsonEncode(allInfo));
    add(DirectMasterAddTimeEvent());
    isEdit ? {} : Get.back();
  }
}
