import 'package:cutfx_salon/model/cat/categories.dart';
import 'package:cutfx_salon/model/service/services.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

part 'add_service_event.dart';
part 'add_service_state.dart';

class AddServiceBloc extends Bloc<AddServiceEvent, AddServiceState> {
  AddServiceBloc() : super(AddServiceInitial()) {
    fetchCategories();
    on<CategoryDataFetchedEvent>(
      (event, emit) {
        emit(CategoryDataFetchedState());
      },
    );
    on<AddImageEvent>((event, emit) {
      emit(AddServiceAddImageState());
    });
  }

  Categories? categories;
  int selectedCatId = -1;
  ServiceData? serviceData;
  TextEditingController serviceTitleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController timeItTakesController = TextEditingController();
  TextEditingController aboutServiceController = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  List<Images>? imageList = [];

  List<String> deleteIds = [];
  int gender = 0;

  void fetchCategories() async {
    serviceData = Get.arguments;
    if (serviceData != null) {
      selectedCatId = serviceData?.categoryId ?? 0;
      serviceTitleController.text = serviceData?.title ?? '';
      priceController.text = serviceData?.price?.toString() ?? '';
      discountController.text = serviceData?.discount?.toString() ?? '';
      timeItTakesController.text = serviceData?.serviceTime?.toString() ?? '';
      gender = serviceData?.gender ?? 0;
      aboutServiceController.text = serviceData?.about ?? '';
      imageList = serviceData?.images ?? [];
    }
    aboutServiceController.addListener(() {
      add(CategoryDataFetchedEvent());
    });
    categories = await ApiService().fetchSalonCategories();
    add(CategoryDataFetchedEvent());
  }

  void selectCatId(int categoryId) {
    selectedCatId = categoryId;
  }

  void onAddImageClick() async {
    final selectedImages = await imagePicker.pickMultiImage(imageQuality: 70);
    if (selectedImages.isEmpty) return;
    if (selectedImages.isNotEmpty) {
      for (XFile image in selectedImages) {
        imageFileList?.add(image);
        imageList?.add(Images(id: -123, serviceId: -1, image: image.path));
      }
      add(AddImageEvent());
    }
  }

  void onTapRemoveImage(int index) async {
    XFile? imageOne;
    for (XFile image in imageFileList!) {
      if (image.path == imageList?[index].image) {
        imageOne = image;
      }
    }
    if (imageOne != null) {
      imageFileList?.remove(imageOne);
    }
    deleteIds.add(imageList![index].id.toString());
    imageList?.removeAt(index);
    add(AddImageEvent());
  }

  void onTapSubmit() async {
    if (selectedCatId == -1) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseSelectCategory,
        false,
      );
      return;
    }
    if (serviceTitleController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterServiceTitle,
        false,
      );
      return;
    }
    if (priceController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterPrice,
        false,
      );
      return;
    }
    if (timeItTakesController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterTimeItTakes,
        false,
      );
      return;
    }
    if (imageList == null || imageList!.isEmpty || imageList!.length < 3) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseSelectMinimum3Images,
        false,
      );
      return;
    }
    AppRes.showCustomLoader();
    if (serviceData != null) {
      await ApiService().editService(
        serviceId: serviceData?.id?.toString() ?? '-1',
        catId: selectedCatId.toString(),
        title: serviceTitleController.text,
        price: priceController.text,
        discount: discountController.text,
        gender: gender.toString(),
        serviceTime: timeItTakesController.text,
        salonImages: imageFileList,
        about: aboutServiceController.text,
        deleteImageIds: deleteIds,
      );
    } else {
      await ApiService().addServiceToSalon(
        catId: selectedCatId.toString(),
        title: serviceTitleController.text,
        price: priceController.text,
        discount: discountController.text,
        gender: gender.toString(),
        serviceTime: timeItTakesController.text,
        salonImages: imageFileList,
        about: aboutServiceController.text,
      );
    }
    AppRes.hideCustomLoaderWithBack();
  }
}
