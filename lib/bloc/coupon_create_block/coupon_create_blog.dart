import 'package:cutfx_salon/utils/app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

part 'coupon_create_event.dart';part 'coupon_create_state.dart';

class CouponCreateBloc extends Bloc<EditCouponEvent, EditCouponState> {
  CouponCreateBloc() : super(EditCouponInitial()) {
    on<FetchedCouponEvent>((event, emit) {
      emit(FetchedDataState());
    });

    initData();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController salonController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void initData() async {
    add(FetchedCouponEvent());
  }

  Future<void> onTapSubmit() async {
    if (nameController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterBankName,
        false,
      );
      return;
    }
    if (salonController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterAccountNumber,
        false,
      );
      return;
    }
    if (discountController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterRenterAccountNumber,
        false,
      );
      return;
    }
    if (timeController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.accountNumberDoesNotMatch,
        false,
      );
      return;
    }
    if (priceController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterHoldersName,
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
    // await ApiService().updateSalonBankAccount(
    //   salonId: ConstRes.salonId,
    //   bankTitle: bankNameController.text,
    //   accountNumber: accountNumberController.text,
    //   holder: holderNameController.text,
    //   swiftCode: swiftCodeController.text,
    //   chequePhoto: cancelledCheque,
    // );
    AppRes.hideCustomLoaderWithBack();
  }
}
