import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_profile_event.dart';

part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<FetchUserProfileEvent>((event, emit) async {
      //   if (salonUser != null) {
      //     fullNameTextController.text = salonUser.data?.fullname ?? '';
      //     phoneNumberTextController.text = salonUser.data?.phoneNumber ?? '';
      //     imageUrl = salonUser.data?.profileImage ?? '';
      //
      //     phoneNumberTextController.text =
      //         findSalonNumber(salonUser.data?.phoneNumber);
      //     dailCode = findSalonCountryCode(salonUser.data?.phoneNumber);
      //     salonPhone =
      //         '$dailCode ${findSalonNumber(salonUser.data?.phoneNumber)}';
      //     emit(UserDataFoundState(salonUser));
      //   }
      // });
      // on<SubmitEditProfileEvent>(
      //   (event, emit) async {
      //     if (fullNameTextController.text.isEmpty) {
      //       AppRes.showSnackBar(
      //           AppLocalizations.of(Get.context!)!.enterYourFullname, false);
      //       return;
      //     }
      //     AppRes.showCustomLoader();
      //     await ApiService().editUserDetails(
      //       fullname: fullNameTextController.text,
      //       phoneNumber: salonPhone,
      //       profileImage: imageFile,
      //     );
      //     AppRes.hideCustomLoaderWithBack();
      //   },
    });
    on<ImageSelectClickEvent>((event, emit) async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      imageFile = image != null ? File(image.path) : null;
      add(FetchUserProfileEvent());
    });

    add(FetchUserProfileEvent());
  }

  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController phoneNumberTextController = TextEditingController();
  String salonPhone = '';
  String dailCode = '91';
  File? imageFile;
  String? imageUrl;



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
}
