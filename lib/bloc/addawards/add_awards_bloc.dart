import 'package:cutfx_salon/model/rest/rest_response.dart';
import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

part 'add_awards_event.dart';
part 'add_awards_state.dart';

class AddAwardsBloc extends Bloc<AddAwardsEvent, AddAwardsState> {
  Awards? awards;

  AddAwardsBloc() : super(AddAwardsInitial()) {
    on<TextChangeEvent>((event, emit) {
      emit(ChangeTextState());
    });
    descriptionController.addListener(() {
      add(TextChangeEvent());
    });
    awards = Get.arguments;
    awardTitleController.text = awards?.title ?? '';
    awardByController.text = awards?.awardBy ?? '';
    descriptionController.text = awards?.description ?? '';
  }

  TextEditingController awardTitleController = TextEditingController();
  TextEditingController awardByController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void onTapSubmit() async {
    if (awardTitleController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterAwardTitle,
        false,
      );
      return;
    }
    if (awardByController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterAwardBy,
        false,
      );
      return;
    }
    if (descriptionController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterDescription,
        false,
      );
      return;
    }
    AppRes.showCustomLoader();
    RestResponse response;
    if (awards != null) {
      response = await ApiService().editSalonAward(
        awardId: awards?.id.toString() ?? '',
        title: awardTitleController.text,
        awardBy: awardByController.text,
        description: descriptionController.text,
      );
    } else {
      response = await ApiService().addSalonAward(
        title: awardTitleController.text,
        awardBy: awardByController.text,
        description: descriptionController.text,
      );
    }
    if (response.status!) {
      AppRes.hideCustomLoaderWithBack();
    } else {
      AppRes.hideCustomLoader();
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseTryAgain,
        false,
      );
    }
  }
}
