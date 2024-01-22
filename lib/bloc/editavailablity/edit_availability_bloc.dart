import 'package:cutfx_salon/bloc/singnup/sign_up_bloc.dart';
import 'package:cutfx_salon/model/slot/slot.dart';
import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_bottom_sheet.dart';
import 'package:cutfx_salon/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

part 'edit_availability_event.dart';
part 'edit_availability_state.dart';

class EditAvailabilityBloc
    extends Bloc<EditAvailabilityEvent, EditAvailabilityState> {
  EditAvailabilityBloc() : super(EditAvailabilityInitial()) {
    on<EditTimeClickEvent>(
      (event, emit) {
        emit(EditAvailabilityTimeState(event.timeTypeClick));
      },
    );
    on<FetchedEditAvailabilityEvent>(
      (event, emit) {
        emit(FetchedEditAvailabilityState());
      },
    );
    initData();
  }

  String startTime = "00:00";
  String endTime = "00:00";
  String? monFriFrom;
  String? monFriTo;
  String? satSunFrom;
  String? satSunTo;
  TimeOfDay? monFriFromTimeOfDay;
  TimeOfDay? monFriToTimeOfDay;
  TimeOfDay? satSunFromTimeOfDay;
  TimeOfDay? satSunToTimeOfDay;
  Salon? salonData;
  Map<String, List<SlotData>> salonSlots = {};

  void initData() async {
    SharePref sharePref = await SharePref().init();
    Salon? salon = sharePref.getSalon();
    salonData = salon;
    monFriFrom = AppRes.convert24HoursInto12Hours(salon?.data?.monFriFrom);
    monFriTo = AppRes.convert24HoursInto12Hours(salon?.data?.monFriTo);
    satSunFrom = AppRes.convert24HoursInto12Hours(salon?.data?.satSunFrom);
    satSunTo = AppRes.convert24HoursInto12Hours(salon?.data?.satSunTo);
    monFriFromTimeOfDay = TimeOfDay(
        hour: int.parse(salon?.data?.monFriFrom?.substring(0, 2) ?? '0'),
        minute: int.parse(salon?.data?.monFriFrom?.substring(2, 4) ?? '0'));
    monFriToTimeOfDay = TimeOfDay(
        hour: int.parse(salon?.data?.monFriTo?.substring(0, 2) ?? '0'),
        minute: int.parse(salon?.data?.monFriTo?.substring(2, 4) ?? '0'));
    satSunFromTimeOfDay = TimeOfDay(
        hour: int.parse(salon?.data?.satSunFrom?.substring(0, 2) ?? '0'),
        minute: int.parse(salon?.data?.satSunFrom?.substring(2, 4) ?? '0'));
    satSunToTimeOfDay = TimeOfDay(
        hour: int.parse(salon?.data?.satSunTo?.substring(0, 2) ?? '0'),
        minute: int.parse(salon?.data?.satSunTo?.substring(2, 4) ?? '0'));
    for (SlotData slotData in salonData?.data?.slots ?? []) {
      print('${slotData.weekday} ${slotData.time}');
    }
    List.generate(DateFormat().dateSymbols.WEEKDAYS.length, (index) {
      salonSlots[DateFormat().dateSymbols.WEEKDAYS[index]] =
          salonData?.data?.slots?.where((element) {
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
    add(FetchedEditAvailabilityEvent());
  }

  void onTimeClick(int type, EditAvailabilityBloc signUpBloc) async {
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
    await Get.bottomSheet(
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
                      time: DateTime(DateTime.now().year, DateTime.now().month,
                          DateTime.now().day, 0),
                      minutesInterval: 15,
                      is24HourMode: true,
                      normalTextStyle:
                          const TextStyle(fontSize: 24, color: Colors.grey),
                      highlightedTextStyle: const TextStyle(
                          fontSize: 24, color: ColorRes.themeColor),
                      spacing: 50,
                      itemHeight: 80,
                      isForce2Digits: true,
                      onTimeChange: (time) {
                        selectedTimeRTL =
                            TimeOfDay(hour: time.hour, minute: time.minute);
                      },
                    ),
                  ],
                )),
            enableDrag: false)
        .then((value) {
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
      signUpBloc.add(EditTimeClickEvent(type));
    });
  }

  Future<void> onTapSubmit() async {
    if (monFriFrom == null || monFriFrom!.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseSelectMonFriFromTime, false);
      return;
    }
    if (monFriTo == null || monFriTo!.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseSelectMonFriToTime, false);
      return;
    }
    if (satSunFrom == null || satSunFrom!.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseSelectSatSunFromTime, false);
      return;
    }
    if (satSunTo == null || satSunTo!.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseSelectSatSunToTime, false);
      return;
    }
    AppRes.showCustomLoader();
    await ApiService().updateSalonDetails(
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
    AppRes.hideCustomLoaderWithBack();
  }

  void onAddSlotClick(TimeOfDay? timeOfDay, int slotLimit,
      EditAvailabilityBloc editAvailabilityBloc, int index) async {
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
    salonData = await ApiService().addBookingSlots(
        '${0.convert2Digits(timeOfDay?.hour)}${0.convert2Digits(timeOfDay?.minute)}',
        weekDay.toString(),
        slotLimit.toString());
    AppRes.hideCustomLoaderWithBack();
    List.generate(DateFormat().dateSymbols.WEEKDAYS.length, (index) {
      salonSlots[DateFormat().dateSymbols.WEEKDAYS[index]] =
          salonData?.data?.slots?.where((element) {
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
    editAvailabilityBloc.add(FetchedEditAvailabilityEvent());
  }

  void deleteSlotBooking(
      SlotData? slotData, EditAvailabilityBloc editAvailabilityBloc) {
    Get.bottomSheet(
      ConfirmationBottomSheet(
        title:
            '${AppLocalizations.of(Get.context!)!.deleteSlot} (${AppRes.convert24HoursInto12Hours(slotData?.time)})',
        description:
            AppLocalizations.of(Get.context!)!.doYouReallyWantToDeleteThisSlot,
        buttonText: AppLocalizations.of(Get.context!)!.delete,
        onButtonClick: () async {
          AppRes.showCustomLoader();
          salonData = await ApiService()
              .deleteBookingSlots(slotId: slotData?.id?.toInt() ?? -1);
          AppRes.hideCustomLoaderWithBack();
          List.generate(DateFormat().dateSymbols.WEEKDAYS.length, (index) {
            salonSlots[DateFormat().dateSymbols.WEEKDAYS[index]] =
                salonData?.data?.slots?.where((element) {
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
          editAvailabilityBloc.add(FetchedEditAvailabilityEvent());
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
}
