import 'dart:convert';
import 'dart:io';

import 'package:cutfx_salon/model/status_message.dart';
import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/screens/add_master/master_list_screen.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/calendar/calendar_date.dart';
import '../../model/masters/master_responce.dart';
import '../../utils/app_res.dart';
import '../../utils/shared_pref.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<FetchUserProfileEvent>((event, emit) async {
      if (Get.arguments != null) {
        takeAllInformation(Get.arguments);
      }
      emit(UserDataFoundState());
    });
    on<SubmitEditProfileEvent>(
          (event, emit) async {
        if (fullNameTextController.text.isEmpty) {
          AppRes.showSnackBar("please enter full name", false);
          return;
        }
        AppRes.showCustomLoader();
        createMaster(needCreate);
        AppRes.hideCustomLoaderWithBack();
      },
    );
    on<ImageSelectClickEvent>((event, emit) async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      imageFile = image != null ? File(image.path) : null;
      add(FetchUserProfileEvent());
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
  bool needCreate = true;

  void takeAllInformation(Master? master) async {
    if (master != null) {
      needCreate = false;
      imageUrl = master.photo ?? "";
      id = master.id.toString() ?? '';
      fullNameTextController.text = master.fullname ?? "";
      dates = CalendarDates.decode(master.worktime ?? '');
      int services = master.services?.length ?? 0;
      ids.clear();
      for (int i = 0; i < services; i++) {
        if (master.services![i].isNumericOnly) {
          ids.add(int.parse(master.services?[i] ?? "0"));
          Get.log(ids.toString());
          master.worktime;
        }
      }
    } else {
      needCreate = false;
      SharePref sharePref = await SharePref().init();
      final String dateString = sharePref.getString(AppRes.calendarDates) ?? "";
      dates = CalendarDates.decode(dateString);
      add(FetchUserProfileEvent());
    }
  }

  void takeTimeForResult() async {
    SharePref sharePref = await SharePref().init();
    final String dateString = sharePref.getString(AppRes.calendarDates) ?? "";
    if(dateString.length> 3) {
      Map<String, dynamic> valueMap = json.decode(dateString);
      Get.log("${valueMap['date'][0]['date']}bu list");
      for (int b = 0; b < valueMap['date'].length; b++) {
        for (int i = 0; i < valueMap['date'][b]['date'].length; i++) {
          dates.add(CalendarDates(
              start: valueMap['date'][b]['date'][i]['start'],
              end: valueMap['date'][b]['date'][i]['end'],
              date: valueMap['date'][b]['date'][i]['date']));
        }
      }
      add(FetchUserProfileEvent());
    }else{
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

  void createMaster(bool needCreate) async {
    takeTimeForResult();
    SharePref sharePref = await SharePref().init();
    Salon? salon = sharePref.getSalon();
    if (fullNameTextController.text.isEmpty) {
      AppRes.showSnackBar("please enter full name", false);
      return;
    } else if (imageFile == null) {
      AppRes.showSnackBar("please choose master photo", false);
      return;
    } else if (dates.isEmpty) {
      AppRes.showSnackBar("choose master work time", false);
      return;
    } else if (ids.isEmpty) {
      AppRes.showSnackBar("please choose services", false);
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
            status: "1");
        if (statusMessage.status == true) {
          AppRes.showSnackBar(
              statusMessage.message ?? "successfully added", true);
          SharePref sharePref = await SharePref().init();

          sharePref.saveString(AppRes.calendarDates, '');
          dates.clear();
          ids.clear();
          Get.off(() => const MasterListScreen());
        } else {
          AppRes.hideCustomLoader();
          AppRes.showSnackBar(statusMessage.message ?? "error", false);
        }
        AppRes.hideCustomLoader();
      } else {
        AppRes.showCustomLoader();
        StatusMessage statusMessage = await ApiService().editMaster(
            fullName: fullNameTextController.text,
            worktime: dates,
            services: ids,
            id: id,
            ownerPhoto: imageFile,
            status: "1");
        if (statusMessage.status == true) {
          AppRes.hideCustomLoader();

          AppRes.showSnackBar(
              statusMessage.message ?? "successfully edited", true);
          SharePref sharePref = await SharePref().init();
          sharePref.saveString(AppRes.calendarDates, '');
          dates.clear();
          ids.clear();
          Get.off(() => const MasterListScreen());
        } else {
          AppRes.hideCustomLoader();
          AppRes.showSnackBar(statusMessage.message ?? "error", false);
        }
      }
    }
  }
}
