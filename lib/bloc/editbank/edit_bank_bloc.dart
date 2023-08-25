import 'dart:io';

import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_bank_event.dart';
part 'edit_bank_state.dart';

class EditBankBloc extends Bloc<EditBankEvent, EditBankState> {
  EditBankBloc() : super(EditBankInitial()) {
    on<EditCancelChequePhotoEvent>((event, emit) {
      cancelledCheque = File(event.ownerPhoto?.path ?? '');
      emit(EditCancelChequePhotoState());
    });
    on<FetchedEditBankEvent>((event, emit) {
      emit(FetchedDataState());
    });

    initData();
  }

  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController reEnterAccountNumberController =
      TextEditingController();
  TextEditingController holderNameController = TextEditingController();
  TextEditingController swiftCodeController = TextEditingController();
  File? cancelledCheque;
  String? cancelledChequeUrl;
  Salon? salon;

  void initData() async {
    SharePref sharePref = await SharePref().init();
    salon = sharePref.getSalon();
    bankNameController.text = salon?.data?.bankAccount?.bankTitle ?? '';
    accountNumberController.text =
        salon?.data?.bankAccount?.accountNumber ?? '';
    reEnterAccountNumberController.text =
        salon?.data?.bankAccount?.accountNumber ?? '';
    holderNameController.text = salon?.data?.bankAccount?.holder ?? '';
    swiftCodeController.text = salon?.data?.bankAccount?.swiftCode ?? '';
    cancelledChequeUrl =
        '${ConstRes.itemBaseUrl}${salon?.data?.bankAccount?.chequePhoto}';
    add(FetchedEditBankEvent());
  }

  Future<void> onTapSubmit() async {
    if (bankNameController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterBankName,
        false,
      );
      return;
    }
    if (accountNumberController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterAccountNumber,
        false,
      );
      return;
    }
    if (reEnterAccountNumberController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterRenterAccountNumber,
        false,
      );
      return;
    }
    if (accountNumberController.text != reEnterAccountNumberController.text) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.accountNumberDoesNotMatch,
        false,
      );
      return;
    }
    if (holderNameController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterHoldersName,
        false,
      );
      return;
    }
    if (swiftCodeController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterSwiftCode,
        false,
      );
      return;
    }
    // if (cancelledCheque == null) {
    //   AppRes.showSnackBar(
    //       AppLocalizations.of(Get.context!)!.selectCancelledCheque);
    //   return;
    // }
    AppRes.showCustomLoader();
    await ApiService().updateSalonBankAccount(
      salonId: ConstRes.salonId,
      bankTitle: bankNameController.text,
      accountNumber: accountNumberController.text,
      holder: holderNameController.text,
      swiftCode: swiftCodeController.text,
      chequePhoto: cancelledCheque,
    );
    AppRes.hideCustomLoaderWithBack();
  }
}
