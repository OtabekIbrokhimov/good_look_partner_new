import 'package:cutfx_salon/service/api_service.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

part 'add_image_event.dart';
part 'add_image_state.dart';

class AddImageBloc extends Bloc<AddImageEvent, AddImageState> {
  AddImageBloc() : super(AddImageInitial()) {
    on<AddImageClickEvent>((event, emit) async {
      imageOfGallery = await imagePicker.pickImage(source: ImageSource.gallery);
      emit(ImageSelectState());
    });
    on<AddSubmitClickEvent>((event, emit) async {
      if (imageOfGallery == null) {
        AppRes.showSnackBar(
            AppLocalizations.of(Get.context!)!.pleaseSelectImage, false);
        return;
      }
      AppRes.showCustomLoader();
      await ApiService().addSalonGalleryImage(
          image: imageOfGallery!, description: descriptionController.text);
      AppRes.hideCustomLoaderWithBack();
    });
  }

  ImagePicker imagePicker = ImagePicker();
  XFile? imageOfGallery;
  TextEditingController descriptionController = TextEditingController();
}
