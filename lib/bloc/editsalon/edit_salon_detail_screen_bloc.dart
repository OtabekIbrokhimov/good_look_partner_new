import 'package:cutfx_salon/model/cat/categories.dart' as cat;
import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/screens/map/select_location_screen.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_dialog.dart';
import 'package:cutfx_salon/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_salon_detail_screen_event.dart';
part 'edit_salon_detail_screen_state.dart';

class EditSalonDetailBloc
    extends Bloc<EditSalonDetailEvent, EditSalonDetailState> {
  EditSalonDetailBloc() : super(EditSalonDetailScreenInitial()) {
    aboutSalonController.addListener(() {});
    on<EditSalonFetchedCatsEvent>((event, emit) {
      emit(EditSalonFetchedCatsState(event.categories));
    });
    on<AddImageEvent>((event, emit) {
      emit(EditSalonAddImageState());
    });
    on<FetchLocationEvent>((event, emit) {
      emit(EditSalonAddImageState());
    });
  }

  LatLng? latLng;
  int? selectedIndex;

  Salon? salon;
  List<cat.CategoryData>? categories = [];
  List<String> categoryIds = [];
  List<Images>? imageList = [];
  TextEditingController salonNameController = TextEditingController();
  TextEditingController aboutSalonController = TextEditingController();
  TextEditingController salonAddressController = TextEditingController();
  TextEditingController salonPhoneController = TextEditingController();
  String salonPhone = '';
  String dailCode = '91';
  TextEditingController salonLocationController = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  List<String> deleteIds = [];

  void fetchCategories() async {
    SharePref().init().then((value) {
      categories = value.getSettings()?.data?.categories ?? [];
      salon = value.getSalon();
      salonNameController.text = salon?.data?.salonName ?? '';
      aboutSalonController.text = salon?.data?.salonAbout ?? '';
      salonAddressController.text = salon?.data?.salonAddress ?? '';
      salonPhoneController.text = findSalonNumber(salon?.data?.salonPhone);
      dailCode = findSalonCountryCode(salon?.data?.salonPhone);
      salonPhone = '$dailCode ${findSalonNumber(salon?.data?.salonPhone)}';
      imageList = salon?.data?.images;
      latLng = LatLng(double.parse(salon?.data?.salonLat ?? '-1'),
          double.parse(salon?.data?.salonLong ?? '-1'));

      for (int i = 0; i < categories!.length; i++) {
        for (int j = 0;
            j < salon!.data!.salonCategories!.split(",").length;
            j++) {
          if (categories?[i].id != null &&
              salon?.data?.salonCategories?.split(",")[j] ==
                  categories?[i].id.toString()) {
            categoryIds.add(categories![i].id.toString());
          }
        }
      }
    });

    add(EditSalonFetchedCatsEvent(categories));
  }

  void onAddImageClick() async {
    final selectedImages = await imagePicker.pickMultiImage(imageQuality: 50);
    if (selectedImages.isEmpty) return;
    if (selectedImages.isNotEmpty) {
      for (XFile image in selectedImages) {
        imageFileList?.add(image);
        imageList?.add(
            Images(id: -123, salonId: ConstRes.salonId, image: image.path));
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
    if (salonNameController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterSalonName,
        false,
      );
      return;
    }
    if (aboutSalonController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterAboutSalon,
        false,
      );
      return;
    }
    if (salonAddressController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterSalonAddress,
        false,
      );
      return;
    }
    if (salonPhoneController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterSalonPhone,
        false,
      );
      return;
    }
    if (categoryIds.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseSelectAtLeastOneCategory,
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
    showDialog(
      context: Get.context!,
      builder: (context) {
        return const CustomLoader();
      },
      barrierDismissible: false,
    );
    await ApiService().updateSalonDetails(
      salonId: ConstRes.salonId,
      salonName: salonNameController.text,
      salonAbout: aboutSalonController.text,
      salonPhone: salonPhone,
      salonAddress: salonAddressController.text,
      salonImages: imageFileList,
      deleteImageIds: deleteIds,
      salonLat: latLng?.latitude,
      salonLong: latLng?.longitude,
      salonCategories: categoryIds.join(","),
      genderServed: selectedIndex?.toString(),
    );
    Get.back();
    Get.back();
  }

  void onTapFetchLocation() {
    Get.to(
      const SelectLocationScreen(),
    )?.then((value) {
      latLng = value;
      add(FetchLocationEvent());
    });
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
}
