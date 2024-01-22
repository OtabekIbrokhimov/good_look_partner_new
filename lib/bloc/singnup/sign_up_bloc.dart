import 'dart:io';

import 'package:cutfx_salon/bloc/singnup/sign_up_event.dart';
import 'package:cutfx_salon/bloc/singnup/sign_up_state.dart';
import 'package:cutfx_salon/model/cat/categories.dart' as cat;
import 'package:cutfx_salon/model/rest/rest_response.dart';
import 'package:cutfx_salon/model/slot/slot.dart';
import 'package:cutfx_salon/screens/map/select_location_screen.dart';
import 'package:cutfx_salon/screens/registration/salonDetail/signup_salon_details_screen.dart';
import 'package:cutfx_salon/screens/registration/sign_up_done_screen.dart';
import 'package:cutfx_salon/screens/registration/signup_salon_address.dart';
import 'package:cutfx_salon/screens/registration/signup_salon_availability.dart';
import 'package:cutfx_salon/screens/registration/signup_salon_bank_widget.dart';
import 'package:cutfx_salon/screens/registration/signup_salon_categories_widget.dart';
import 'package:cutfx_salon/screens/registration/signup_salon_images_widget.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_bottom_sheet.dart';
import 'package:cutfx_salon/utils/custom/custom_dialog.dart';
import 'package:cutfx_salon/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../model/user/salon.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SharePref? sharePref;
  Salon? user;
  String? title;
  List<Widget> list = [];
  int selectPosition = 0;

  ///FirstPage
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController salonNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  XFile? ownerImage;

  ///SecondPage
  TextEditingController aboutSalonController = TextEditingController();
  TextEditingController salonAddressController = TextEditingController();
  TextEditingController salonPhoneController = TextEditingController();
  String salonPhone = '';
  LatLng? latLng;

  ///ThirdPage
  String? monFriFrom;
  String? monFriTo;
  String? satSunFrom;
  String? satSunTo;
  TimeOfDay? monFriFromTimeOfDay;
  TimeOfDay? monFriToTimeOfDay;
  TimeOfDay? satSunFromTimeOfDay;
  TimeOfDay? satSunToTimeOfDay;
  List<String> time = [];
  Map<String, List<SlotData>> salonSlots = {};

  ///FourthPage
  cat.Categories? categories;
  List<String> categoryIds = [];
  String? genderYouServed = '0';

  ///FifthPage
  List<XFile?> salonImages = [];

  ///SixthPage
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController reEnterAccountNumberController =
      TextEditingController();
  TextEditingController holderNameController = TextEditingController();
  TextEditingController swiftCodeController = TextEditingController();
  File? cancelledCheque;

  SignUpBloc() : super(SignUpInitialState()) {
    initPage();

    on<SignUpNextClickEvent>(
      (event, emit) async {
        if (event.selectedPosition == 1) {
          if (user == null) {
            Salon? salon = await callApiForRegistration();
            if (salon == null) {
              return;
            }
            user = salon;
            Get.back();
          }
        } else if (event.selectedPosition == 2 &&
            user != null &&
            (user?.data?.salonAbout == null ||
                user!.data!.salonAbout!.isEmpty)) {
          Salon? salon = await updateSalonDetails();
          if (salon == null) {
            return;
          }
          Get.back();
          user = salon;
        } else if (event.selectedPosition == 3 &&
            user != null &&
            (user?.data?.monFriFrom == null ||
                user!.data!.monFriFrom!.isEmpty)) {
          Salon? salon = await updateSalonAvailability();
          if (salon == null) {
            return;
          }
          Get.back();
          user = salon;
        } else if (event.selectedPosition == 4 &&
            user != null &&
            (user?.data?.salonCategories == null ||
                user!.data!.salonCategories!.isEmpty)) {
          Salon? salon = await updateCategoriesAndGender();
          if (salon == null) {
            return;
          }
          Get.back();
          user = salon;
        } else if (event.selectedPosition == 5 &&
            user != null &&
            (user?.data?.images == null || user!.data!.images!.isEmpty)) {
          Salon? salon = await updateSalonImages();
          if (salon == null) {
            return;
          }
          Get.back();
          user = salon;
        } else if (event.selectedPosition == 6 &&
            user != null &&
            (user?.data?.bankAccount == null)) {
          RestResponse? restResponse = await updateBankDetails();
          if (restResponse == null) {
            return;
          }
          Get.back();
          Get.to(() => const SignUpDoneScreen());
          return;
        }
        if (user != null) {
          selectPosition = event.selectedPosition;
          emit(SignUpPageChangeState(event.selectedPosition));
        }
      },
    );

    on<SignUpOwnerPhotoEvent>((event, emit) {
      ownerImage = event.ownerPhoto;
      emit(SignUpOwnerPhotoState(event.ownerPhoto));
    });

    on<SignUpLocationClickEvent>(
      (event, emit) {
        latLng = event.latLng;
        emit(SignUpLocationFetchState(event.latLng));
      },
    );

    on<SignUpTimeClickEvent>(
      (event, emit) {
        emit(SignUpTimeState(event.timeTypeClick));
      },
    );
  }

  void onFetchLocationClick(SignUpBloc signUpBloc) {
    Get.to(
      () => const SelectLocationScreen(),
    )?.then((value) {
      latLng = value;
      signUpBloc.add(SignUpLocationClickEvent(latLng));
    });
  }

  final ImagePicker imagePicker = ImagePicker();

  void onImageClick(SignUpBloc signUpBloc) async {
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    salonImages.add(xFile);
    signUpBloc.add(SignUpOwnerPhotoEvent(xFile));
  }

  void onTimeClick(
      int type, SignUpBloc signUpBloc, BuildContext context) async {
    if (type == 1 && monFriFrom == null) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseSelectFromTimeFirst, false);
      return;
    }
    if (type == 3 && satSunFrom == null) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseSelectFromTimeFirst, false);
      return;
    }
    TimeOfDay? selectedTimeRTL;
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.all(15),
          height: Get.height / 2,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close,
                        color: ColorRes.black,
                        size: 35,
                      )),
                ],
              ),
              TimePickerSpinner(
                minutesInterval: 15,
                is24HourMode: true,
                normalTextStyle:
                    const TextStyle(fontSize: 24, color: Colors.grey),
                highlightedTextStyle:
                    const TextStyle(fontSize: 24, color: ColorRes.themeColor),
                spacing: 50,
                itemHeight: 80,
                isForce2Digits: true,
                onTimeChange: (time) {
                  selectedTimeRTL =
                      TimeOfDay(hour: time.hour, minute: time.minute);
                  add(SignUpTimeClickEvent(type));
                  Get.log(time.toString() + selectedTimeRTL.toString());
                  if (selectedTimeRTL == null) return;
                  if (type == 0) {
                    monFriFromTimeOfDay = selectedTimeRTL;
                    monFriFrom =
                        '${0.convert2Digits(selectedTimeRTL?.hourOfPeriod)}:${0.convert2Digits(selectedTimeRTL?.minute)} ${selectedTimeRTL?.period.name.toUpperCase()}';
                  } else if (type == 1) {
                    monFriToTimeOfDay = selectedTimeRTL;
                    monFriTo =
                        '${0.convert2Digits(selectedTimeRTL?.hourOfPeriod)}:${0.convert2Digits(selectedTimeRTL?.minute)} ${selectedTimeRTL?.period.name.toUpperCase()}';
                    if ((monFriFromTimeOfDay?.hour ?? 0) >=
                        (monFriToTimeOfDay?.hour ?? 0)) {
                      monFriTo = null;
                      monFriToTimeOfDay = null;
                      AppRes.showSnackBar(
                          '${AppLocalizations.of(Get.context!)!.selectTimeAfter} $monFriFrom',
                          false);
                    }
                  } else if (type == 2) {
                    satSunFromTimeOfDay = selectedTimeRTL;
                    satSunFrom =
                        '${0.convert2Digits(selectedTimeRTL?.hourOfPeriod)}:${0.convert2Digits(selectedTimeRTL?.minute)} ${selectedTimeRTL?.period.name.toUpperCase()}';
                  } else if (type == 3) {
                    satSunToTimeOfDay = selectedTimeRTL;
                    satSunTo =
                        '${0.convert2Digits(selectedTimeRTL?.hourOfPeriod)}:${0.convert2Digits(selectedTimeRTL?.minute)} ${selectedTimeRTL?.period.name.toUpperCase()}';
                    if ((satSunFromTimeOfDay?.hour ?? 0) >=
                        (satSunToTimeOfDay?.hour ?? 0)) {
                      satSunTo = null;
                      satSunToTimeOfDay = null;
                      AppRes.showSnackBar(
                          '${AppLocalizations.of(Get.context!)!.selectTimeAfter} $satSunFrom',
                          false);
                    }
                  }
                  Get.log("oxirigacha ishlagan");
                  signUpBloc.add(SignUpTimeClickEvent(type));
                },
              ),
            ],
          )),
      isScrollControlled: false,
    );

    // selectedTimeRTL = await showTimePicker(
    //   context: Get.context!,
    //   initialTime: TimeOfDay(
    //     hour: AppRes.getHourFromTime(type == 0
    //         ? monFriFrom
    //         : type == 1
    //             ? monFriTo
    //             : type == 2
    //                 ? satSunFrom
    //                 : satSunTo),
    //     minute: int.parse(
    //       AppRes.getMinFromTime(type == 0
    //           ? monFriFrom
    //           : type == 1
    //               ? monFriTo
    //               : type == 2
    //                   ? satSunFrom
    //                   : satSunTo),
    //     ),
    //   ),
    //   initialEntryMode: TimePickerEntryMode.dialOnly,
    //   builder: (BuildContext context, Widget? child) {
    //     return Theme(
    //       data: Theme.of(Get.context!).copyWith(
    //         colorScheme: const ColorScheme.light(
    //           primary: ColorRes.themeColor,
    //         ),
    //       ),
    //       child: child!,
    //     );
    //   },
    // );
  }

  void onAddSlotClick(TimeOfDay? timeOfDay, int slotLimit,
      SignUpBloc signUpBloc, int index) async {
    int weekDay = 1;
    if (index == 0) {
      weekDay = 7;
    } else if (index >= 1 && index <= 5) {
      weekDay = index;
    } else {
      weekDay = index;
    }
    if (timeOfDay == null) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseSelectTime, false);
      return;
    }
    AppRes.showCustomLoader();
    await updateSalonAvailability();
    user = await ApiService().addBookingSlots(
        '${0.convert2Digits(timeOfDay.hour)}${0.convert2Digits(timeOfDay.minute)}',
        weekDay.toString(),
        slotLimit.toString());
    AppRes.hideCustomLoaderWithBack();
    List.generate(DateFormat().dateSymbols.WEEKDAYS.length, (index) {
      salonSlots[DateFormat().dateSymbols.WEEKDAYS[index]] =
          user?.data?.slots?.where((element) {
                int weekDay;
                if (index == 0) {
                  weekDay = 7;
                } else if (index >= 1 && index <= 5) {
                  weekDay = index;
                } else {
                  weekDay = index;
                }
                return element.weekday == weekDay;
              }).toList() ??
              [];
    });
    signUpBloc.add(SignUpTimeClickEvent(0));
  }

  void deleteSlotBooking(SlotData? slotData, SignUpBloc signUpBloc) {
    Get.bottomSheet(
      ConfirmationBottomSheet(
        title:
            '${AppLocalizations.of(Get.context!)!.deleteSlot} (${AppRes.convert24HoursInto12Hours(slotData?.time)})',
        description:
            AppLocalizations.of(Get.context!)!.doYouReallyWantToDeleteThisSlot,
        buttonText: AppLocalizations.of(Get.context!)!.delete,
        onButtonClick: () async {
          AppRes.showCustomLoader();
          user = await ApiService()
              .deleteBookingSlots(slotId: slotData?.id?.toInt() ?? -1);
          AppRes.hideCustomLoaderWithBack();
          List.generate(DateFormat().dateSymbols.WEEKDAYS.length, (index) {
            salonSlots[DateFormat().dateSymbols.WEEKDAYS[index]] =
                user?.data?.slots?.where((element) {
                      int weekDay;
                      if (index == 0) {
                        weekDay = 7;
                      } else if (index >= 1 && index <= 5) {
                        weekDay = index;
                      } else {
                        weekDay = index;
                      }
                      return element.weekday == weekDay;
                    }).toList() ??
                    [];
          });
          signUpBloc.add(SignUpTimeClickEvent(0));
        },
      ),
    );
  }

  void onSlotTimeClick(int index, Function(TimeOfDay? time) timeSelect) async {
    TimeOfDay? selectedTimeRTL = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dialOnly,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(Get.context!).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorRes.themeColor,
              onPrimary: Colors.redAccent,
            ),
          ),
          child: child!,
        );
      },
    );
    if (index == 0 || index == 6) {
      if (AppRes.isAvailableForAdd(satSunFrom ?? '0', satSunTo ?? '0',
          selectedTimeRTL ?? TimeOfDay.now())) {
        timeSelect.call(selectedTimeRTL);
      } else {
        AppRes.showSnackBar(
          '${AppLocalizations.of(Get.context!)!.pleaseSelectSlotTimeBetweenYourAvailability} ($satSunFrom to $satSunTo)',
          false,
        );
      }
    } else {
      if (AppRes.isAvailableForAdd(monFriFrom ?? '0', monFriTo ?? '0',
          selectedTimeRTL ?? TimeOfDay.now())) {
        timeSelect.call(selectedTimeRTL);
      } else {
        AppRes.showSnackBar(
          '${AppLocalizations.of(Get.context!)!.pleaseSelectSlotTimeBetweenYourAvailability} ($monFriFrom to $monFriTo)',
          false,
        );
      }
    }
  }

  void onImageDeleteClick(SignUpBloc signUpBloc, int index) async {
    salonImages.removeAt(index);
    signUpBloc.add(SignUpOwnerPhotoEvent(null));
  }

  Future<Salon?> callApiForRegistration() async {
    if (ownerNameController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterSalonOwnerName,
        false,
      );
      return null;
    }
    // if (ownerImage == null) {
    //   AppRes.showSnackBar(
    //     AppLocalizations.of(Get.context!)!.pleaseSelectOwnerImage,
    //     false,
    //   );
    //   return null;
    // }
    if (salonNameController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterSalonName,
        false,
      );
      return null;
    }
    if (emailController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterEmailAddress,
        false,
      );
      return null;
    }
    AppRes.showCustomLoader();
    ApiService().salonRegistration(
      email: emailController.text,
      ownerName: ownerNameController.text,
      ownerPhoto:
          ownerImage?.path != null ? File(ownerImage?.path ?? '') : null,
      salonName: salonNameController.text,
      isRegistration: true,
    );
    AppRes.hideCustomLoader();
    add(SignUpNextClickEvent(2));
    return null;
  }

  Future<Salon?> updateSalonDetails() async {
    if (aboutSalonController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterAboutSalon,
        false,
      );

      return null;
    }
    if (salonAddressController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterSalonAddress,
        false,
      );
      return null;
    }
    if (salonPhoneController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterSalonPhone,
        false,
      );
      return null;
    }
    if (latLng == null) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseSelectSalonLocation,
        false,
      );
      return null;
    }
    AppRes.showCustomLoader();
    return await ApiService().updateSalonDetails(
      salonId: ConstRes.salonId,
      salonAbout: aboutSalonController.text,
      salonAddress: salonAddressController.text,
      salonPhone: salonPhone,
      salonLat: latLng?.latitude,
      salonLong: latLng?.longitude,
    );
  }

  Future<Salon?> updateSalonAvailability() async {
    if (monFriFrom == null || monFriFrom!.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseSelectMonFriFromTime,
        false,
      );
      return null;
    }
    if (monFriTo == null || monFriTo!.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseSelectMonFriToTime,
        false,
      );
      return null;
    }
    if (satSunFrom == null || satSunFrom!.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseSelectSatSunFromTime,
        false,
      );
      return null;
    }
    if (satSunTo == null || satSunTo!.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseSelectSatSunToTime,
        false,
      );
      return null;
    }
    AppRes.showCustomLoader();
    categories = await ApiService().fetchSalonCategories();
    return await ApiService().updateSalonDetails(
      salonId: ConstRes.salonId,
      monFriFrom:
          '${0.convert2Digits(monFriFromTimeOfDay?.hour)}${0.convert2Digits(monFriFromTimeOfDay?.minute)}',
      monFriTo:
          '${0.convert2Digits(monFriToTimeOfDay?.hour)}${0.convert2Digits(monFriToTimeOfDay?.minute)}',
      satSunFrom:
          '${0.convert2Digits(satSunFromTimeOfDay?.hour)}${0.convert2Digits(satSunFromTimeOfDay?.minute)}',
      satSunTo:
          '${0.convert2Digits(satSunToTimeOfDay?.hour)}${0.convert2Digits(satSunToTimeOfDay?.minute)}',
    );
  }

  Future<Salon?> updateCategoriesAndGender() async {
    if (categoryIds.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseSelectAtLeastOneCategory,
        false,
      );
      return null;
    }
    AppRes.showCustomLoader();
    return await ApiService().updateSalonDetails(
        salonId: ConstRes.salonId,
        salonCategories: categoryIds.join(","),
        genderServed: genderYouServed);
  }

  Future<Salon?> updateSalonImages() async {
    // if (salonImages.length < 3) {
    //   AppRes.showSnackBar(
    //     AppLocalizations.of(Get.context!)!.pleaseSelectMinimum3Images,
    //     false,
    //   );
    //   return null;
    // }
    AppRes.showCustomLoader();

    return await ApiService().updateSalonDetails(
      salonId: ConstRes.salonId,
      salonImages: salonImages,
    );
  }

  Future<RestResponse?> updateBankDetails() async {
    if (bankNameController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterBankName,
        false,
      );
      return null;
    }
    if (accountNumberController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterAccountNumber,
        false,
      );
      return null;
    }
    if (reEnterAccountNumberController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterRenterAccountNumber,
        false,
      );
      return null;
    }
    if (accountNumberController.text != reEnterAccountNumberController.text) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.accountNumberDoesNotMatch,
        false,
      );
      return null;
    }
    if (holderNameController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterHoldersName,
        false,
      );
      return null;
    }
    if (swiftCodeController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterSwiftCode,
        false,
      );
      return null;
    }
    if (cancelledCheque == null) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.selectCancelledCheque,
        false,
      );
      return null;
    }
    AppRes.showCustomLoader();
    return await ApiService().updateSalonBankAccount(
      salonId: ConstRes.salonId,
      bankTitle: bankNameController.text,
      accountNumber: accountNumberController.text,
      holder: holderNameController.text,
      swiftCode: swiftCodeController.text,
      chequePhoto: cancelledCheque,
    );
  }

  void initPage() async {
    list.add(const SignUpSalonDetailsScreen());
    list.add(const SignUpSalonAddressWidget());
    list.add(const SignUpSalonAvailabilityWidget());
    list.add(const SignUpSalonCategoriesWidget());
    list.add(const SignUpSalonImagesWidget());
    list.add(SignUpSalonBankWidget());
    sharePref = await SharePref().init();
    ownerNameController.text = sharePref?.getString(AppRes.fullName) ?? "";
    emailController.text = sharePref?.getString(AppRes.phoneNumber) ?? "";

    user = sharePref?.getSalon();
    List.generate(DateFormat().dateSymbols.WEEKDAYS.length, (index) {
      salonSlots[DateFormat().dateSymbols.WEEKDAYS[index]] =
          user?.data?.slots?.where((element) {
                int weekDay;
                if (index == 0) {
                  weekDay = 7;
                } else if (index >= 1 && index <= 5) {
                  weekDay = index;
                } else {
                  weekDay = index;
                }
                return element.weekday == weekDay;
              }).toList() ??
              [];
    });

    ConstRes.salonId = user?.data?.id?.toInt() ?? -1;
    int index = 0;
    if (user?.data?.images != null && user!.data!.images!.isNotEmpty) {
      index = 5;
      showDialog(
        context: Get.context!,
        builder: (context) {
          return const CustomLoader();
        },
        barrierDismissible: false,
      );
      Get.back();
    } else if (user?.data?.salonCategories != null) {
      index = 4;
      showDialog(
        context: Get.context!,
        builder: (context) {
          return const CustomLoader();
        },
        barrierDismissible: false,
      );
      Get.back();
    } else if (user?.data?.monFriFrom != null) {
      index = 3;
      categories = await ApiService().fetchSalonCategories();
    } else if (user?.data?.salonAbout != null) {
      index = 2;
    } else if (user?.data?.salonName != null) {
      index = 1;
    }
    add(SignUpNextClickEvent(index));
  }
}

extension Convert2Digits on int {
  String convert2Digits(int? value) {
    return value.toString().length < 2 ? '0$value' : value.toString();
  }
}
