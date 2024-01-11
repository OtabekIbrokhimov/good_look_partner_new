import 'dart:convert';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:cutfx_salon/generated/l10n.dart';
import 'package:cutfx_salon/model/calendar/CalendarMainList.dart';
import 'package:cutfx_salon/model/calendar/calenda_list.dart';
import 'package:cutfx_salon/model/status_message.dart';
import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/calendar/calendar_date.dart';
import '../../model/masters/master_responce.dart';
import '../../screens/add_master/add_time_screen.dart';
import '../../utils/app_res.dart';
import '../../utils/shared_pref.dart';

part 'edit_profile_event.dart';

part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    if (Get.arguments != null) {
      takeAllInformation(Get.arguments);
    }

    on<FetchUserProfileEvent>((event, emit) async {
      emit(UserDataFoundState());
    });
    on<SubmitEditProfileEvent>(
      (event, emit) async {
        if (fullNameTextController.text.isEmpty) {
          AppRes.showSnackBar(
              AppLocalizations.of(Get.context!)!.pleaseEnterFullName, false);
          return;
        }
        createMaster(needCreate);
      },
    );
    on<ImageSelectClickEvent>((event, emit) async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      imageFile = image != null ? File(image.path) : null;
      emit(ImageClickState());
    });
    on<TakeIdsEvent>((event, emit) async {
      emit(TakeIdsState());
    });

    add(FetchUserProfileEvent());
  }

  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController phoneNumberTextController = TextEditingController();
  String salonPhone = '';
  String dailCode = '998';
  String id = '';
  File? imageFile;
  String imageUrl = '';
  List<int> ids = [];
  List<CalendarDates> dates = [];
  List<CalendarDates> freeDates = [];
  List<CalendarDates> wocDates = [];
  int type = 1;
  bool needCreate = true;

  void takeAllInformation(Master? master) async {
    dates.clear();
    if (master != null) {
      needCreate = false;
      imageUrl = master.photo ?? "";
      id = master.id.toString() ?? '';
      fullNameTextController.text = master.fullname ?? "";
      dates = CalendarDates.decode(master.worktime ?? '');
      freeDates = CalendarDates.decode(master.freetime??"");
      wocDates = CalendarDates.decode(master.vacationtime??"");
      int services = master.services?.length ?? 0;
      ids.clear();
      for (int i = 0; i < services; i++) {
        if (master.services![i].isNumericOnly) {
          ids.add(int.parse(master.services?[i] ?? "0"));
          Get.log(ids.toString());
          master.worktime;
        }
      }
      //takeHourOfWork(dates);
    } else {
      needCreate = false;
    }
  }

  // void takeHourOfWork(List<CalendarDates> list) async {
  //   SharePref sharePref = await SharePref().init();
  //   if (sharePref.getString(AppRes.calendarDates)!.length < 3) {
  //     CalendarMainList? calendarMainList = CalendarMainList(date: []);
  //     int l = list.length;
  //     Map<String, CalendarList> map = {};
  //     for (int i = 0; i < l; i++) {
  //       map['${list[i].start}${list[i].end}'] = CalendarList(date: []);
  //     }
  //     map.forEach((key, value) {
  //       for (int i = 0; i < l; i++) {
  //         if (key == '${list[i].start}${list[i].end}') {
  //           map[key]?.date?.add(list[i]);
  //         }
  //       }
  //     });
  //     map.forEach((key, value) {
  //       calendarMainList.date?.add(value);
  //     });
  //     // if(calendarList.date!.isEmpty){
  //     //   calendarList.date?.add(list[i]);
  //     // }else{
  //     //   if(calendarList.date?.last.start == list[i].start && calendarList.date?.last.end == list[i].end ){
  //     //     Get.log("${calendarList.date?.last.start} == ${list[i].start} && ${calendarList.date?.last.end} == ${list[i].end}");
  //     //     calendarList.date?.add(list[i]);
  //     //     Get.log(calendarList.date!.length.toString());
  //     //   }else{
  //     //     Get.log("${calendarList.date?.last.start} == ${list[i].start} && ${calendarList.date?.last.end} == ${list[i].end}");
  //     //     calendarMainList.date?.add(calendarList);
  //     //     calendarList.date?.clear();
  //     //     calendarList.date?.add(list[i]);
  //     //
  //     //   }
  //     // }}
  //
  //     add(FetchUserProfileEvent());
  //    // sharePref.saveString(AppRes.calendarDates, jsonEncode(calendarMainList));
  //   }
  // }

  void takeTimeForResult() async {
    SharePref sharePref = await SharePref().init();
    final String dateString = sharePref.getString(AppRes.calendarDates) ?? "";
    Get.log(dateString + "date");
    if (dateString.length > 3) {
      if (type == 1) {
        dates.clear();
      } else if (type == 2) {
        freeDates.clear();
      } else {
        wocDates.clear();
      }
      Map<String, dynamic> valueMap = json.decode(dateString);
      Get.log("${valueMap['date'][0]['date']}bu list");
      for (int b = 0; b < valueMap['date'].length; b++) {
        for (int i = 0; i < valueMap['date'][b]['date'].length; i++) {
          if (type == 1) {
            Get.log("worktime");
            dates.add(CalendarDates(
                start: valueMap['date'][b]['date'][i]['start'],
                end: valueMap['date'][b]['date'][i]['end'],
                date: valueMap['date'][b]['date'][i]['date']));
          } else if (type == 2) {
            Get.log("freeTime");
            freeDates.add(CalendarDates(
                start: valueMap['date'][b]['date'][i]['start'],
                end: valueMap['date'][b]['date'][i]['end'],
                date: valueMap['date'][b]['date'][i]['date']));
          } else {
            Get.log("vocation");
            wocDates.add(CalendarDates(
                start: valueMap['date'][b]['date'][i]['start'],
                end: valueMap['date'][b]['date'][i]['end'],
                date: valueMap['date'][b]['date'][i]['date']));
          }
        }
      }
      add(FetchUserProfileEvent());
    } else {
      return;
    }
  }

  String findSalonNumber(String? salonPhone) {
    List<String>? text = salonPhone?.split(' ');
    if (text != null && text.isNotEmpty && text.length >= 2) {
      return text.last;
    }
    return salonPhone ?? '';
  }

  String findSalonCountryCode(String? salonPhone) {
    List<String>? text = salonPhone?.split(' ');
    if (text != null && text.isNotEmpty && text.length >= 2) {
      return text.first;
    }
    return salonPhone ?? '';
  }

  void takeIds(List<int> list) {
    ids = list;
    add(TakeIdsEvent());
  }

  void onTapEdit(String title, int t) async {
    SharePref sharePref = await SharePref().init();
    sharePref.saveString(AppRes.calendarDates, '');
    type = t;
   var result = await Get.to(
        () => AddTimeScreen(
              title: title,
            ),
        arguments: type == 1
            ? dates
            : type == 2
                ? freeDates
                : wocDates);

    takeTimeForResult();
    // dates.clear();
    add(TakeIdsEvent());
  }

  void createMaster(bool needCreate) async {
    takeTimeForResult();
    SharePref sharePref = await SharePref().init();
    Salon? salon = sharePref.getSalon();
    if (fullNameTextController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseEnterFullName, false);
      return;
    }
    // else if (imageFile == null) {
    //   AppRes.showSnackBar(AppLocalizations.of(Get.context!)!.pleaseChooseMasterPhoto, false);
    //   return;
    // }
    else if (freeDates.isEmpty) {
      AppRes.showSnackBar("choose master free time", false);
      return;
    } else if (wocDates.isEmpty) {
      AppRes.showSnackBar("choose master vocation time", false);
      return;
    } else if (dates.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.chooseMasterWorkTime, false);
      return;
    } else if (ids.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.chooseService, false);
      return;
    } else {
      if (needCreate == true) {
        AppRes.showCustomLoader();
        StatusMessage statusMessage = await ApiService().createMaster(
            fullName: fullNameTextController.text,
            worktime: dates,
            services: ids,
            salonId: salon?.data?.id.toString() ?? "",
            ownerPhoto: imageFile,
            status: "1",
            freetime: freeDates,
            woctime: wocDates);
        AppRes.hideCustomLoader();
        if (statusMessage.status == true) {
          Get.back();
          AppRes.showSnackBar(
              statusMessage.message ??
                  AppLocalizations.of(Get.context!)!.successfullyAdded,
              true);
          sharePref.saveString(AppRes.calendarDates, '');
          dates.clear();
          freeDates.clear();
          wocDates.clear();
          ids.clear();
        } else {
          AppRes.showSnackBar(statusMessage.message ?? "error", false);
        }
      } else {
        AppRes.showCustomLoader();
        StatusMessage statusMessage = await ApiService().editMaster(
            fullName: fullNameTextController.text,
            worktime: dates,
            services: ids,
            id: id,
            ownerPhoto: imageFile,
            status: "1",
            freetime: freeDates,
            woctime: wocDates);
        AppRes.hideCustomLoader();
        if (statusMessage.status == true) {
          Get.back();
          AppRes.showSnackBar(
              statusMessage.message ?? "successfully edited", true);
          sharePref.saveString(AppRes.calendarDates, '');
          dates.clear();
          ids.clear();
        } else {
          AppRes.showSnackBar(statusMessage.message ?? "error", false);
        }
      }
    }
  }
}
