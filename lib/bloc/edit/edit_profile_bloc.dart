import 'dart:io';

import 'package:cutfx_salon/model/status_message.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/calendar/calendar_date.dart';
import '../../utils/app_res.dart';
import '../../utils/shared_pref.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<FetchUserProfileEvent>((event, emit) async {
      emit(UserDataFoundState());
    });
    on<SubmitEditProfileEvent>(
      (event, emit) async {
        if (fullNameTextController.text.isEmpty) {
          AppRes.showSnackBar("please enter full name", false);
          return;
        }
        AppRes.showCustomLoader();
        createMaster();
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
  String dailCode = '91';
  File? imageFile;
  String? imageUrl;
  List<int> ids = [];

  List<CalendarDates> dates = [];

  void takeAllInformation() async {
    SharePref sharePref = await SharePref().init();
    final String dateString = sharePref.getString(AppRes.calendarDates) ?? "";
    dates = CalendarDates.decode(dateString);
    add(FetchUserProfileEvent());
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
    Get.log("${list}ishlayabdiku");
    ids = list;
    add(TakeIdsEvent());
  }

  void createMaster() async {
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
      StatusMessage statusMessage = await ApiService().createMaster(
          fullName: fullNameTextController.text,
          worktime: dates,
          services: ids,
          salonId: '11',
          ownerPhoto: imageFile,
          status: "1");
      if (statusMessage.status == true) {
        Get.back();
        AppRes.showSnackBar(
            statusMessage.message ?? "successfully added", true);
        SharePref sharePref = await SharePref().init();
        sharePref.saveString(AppRes.calendarDates, '');
        dates.clear();
        ids.clear();
      } else {
        AppRes.showSnackBar(statusMessage.message ?? "error", false);
      }
    }
  }
}
