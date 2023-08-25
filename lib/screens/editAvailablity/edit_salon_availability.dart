import 'dart:math';

import 'package:cutfx_salon/bloc/editavailablity/edit_availability_bloc.dart';
import 'package:cutfx_salon/model/slot/slot.dart';
import 'package:cutfx_salon/screens/registration/signup_salon_availability.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditSalonAvailabilityWidget extends StatelessWidget {
  const EditSalonAvailabilityWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EditAvailabilityBloc editAvailabilityBloc =
        context.read<EditAvailabilityBloc>();
    return BlocBuilder<EditAvailabilityBloc, EditAvailabilityState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)!.setAvailabilityOfYourSalon,
                      style: kRegularTextStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.mondayFriday,
                      style: kLightTextStyle.copyWith(
                        color: ColorRes.mortar,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              editAvailabilityBloc.onTimeClick(
                                  0, editAvailabilityBloc);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: ColorRes.smokeWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Row(
                                children: [
                                  const Image(
                                    image: AssetImage(
                                      AssetRes.icCalender,
                                    ),
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    editAvailabilityBloc.monFriFrom == null ||
                                            editAvailabilityBloc
                                                .monFriFrom!.isEmpty
                                        ? '00:00'
                                        : editAvailabilityBloc.monFriFrom!,
                                    style: kLightTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            AppLocalizations.of(context)!.to,
                            style: kRegularTextStyle,
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              editAvailabilityBloc.onTimeClick(
                                  1, editAvailabilityBloc);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: ColorRes.smokeWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Row(
                                children: [
                                  const Image(
                                    image: AssetImage(
                                      AssetRes.icCalender,
                                    ),
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    editAvailabilityBloc.monFriTo == null ||
                                            editAvailabilityBloc
                                                .monFriTo!.isEmpty
                                        ? '00:00'
                                        : editAvailabilityBloc.monFriTo!,
                                    style: kLightTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)!.saturdaySunday,
                      style: kLightTextStyle.copyWith(
                        color: ColorRes.mortar,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              editAvailabilityBloc.onTimeClick(
                                  2, editAvailabilityBloc);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: ColorRes.smokeWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Row(
                                children: [
                                  const Image(
                                    image: AssetImage(
                                      AssetRes.icCalender,
                                    ),
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    editAvailabilityBloc.satSunFrom == null ||
                                            editAvailabilityBloc
                                                .satSunFrom!.isEmpty
                                        ? '00:00'
                                        : editAvailabilityBloc.satSunFrom!,
                                    style: kLightTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            AppLocalizations.of(context)!.to,
                            style: kRegularTextStyle,
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              editAvailabilityBloc.onTimeClick(
                                  3, editAvailabilityBloc);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: ColorRes.smokeWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Row(
                                children: [
                                  const Image(
                                    image: AssetImage(
                                      AssetRes.icCalender,
                                    ),
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    editAvailabilityBloc.satSunTo == null ||
                                            editAvailabilityBloc
                                                .satSunTo!.isEmpty
                                        ? '00:00'
                                        : editAvailabilityBloc.satSunTo!,
                                    style: kLightTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)!.addBookingSlotsByWeekDays,
                      style: kRegularTextStyle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .ifYouHaveAddedOnly2SlotsForMondayThen,
                      style:
                          kRegularTextStyle.copyWith(color: ColorRes.empress),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                primary: false,
                itemCount: DateFormat().dateSymbols.WEEKDAYS.length,
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  List<SlotData>? slots = editAvailabilityBloc
                      .salonSlots[DateFormat().dateSymbols.WEEKDAYS[index]];
                  return Container(
                    color: ColorRes.smokeWhite2,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              DateFormat()
                                  .dateSymbols
                                  .WEEKDAYS[index]
                                  .toUpperCase(),
                              style: kSemiBoldTextStyle.copyWith(
                                fontSize: 14,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const Spacer(),
                            CustomCircularInkWell(
                              onTap: () {
                                if (editAvailabilityBloc.monFriFrom == null ||
                                    editAvailabilityBloc.monFriTo == null ||
                                    editAvailabilityBloc.satSunFrom == null ||
                                    editAvailabilityBloc.satSunTo == null) {
                                  AppRes.showSnackBar(
                                      AppLocalizations.of(context)!
                                          .pleaseCompleteAvailabilityFirst,
                                      false);
                                  return;
                                }
                                Get.bottomSheet(
                                  AddSlotDialog(
                                    nameOfDay: editAvailabilityBloc
                                        .salonSlots.keys
                                        .toList()[index],
                                    onTimeSlotClick: (timeSelect) {
                                      editAvailabilityBloc.onSlotTimeClick(
                                          index, timeSelect);
                                    },
                                    onClickSubmit: (timeOfDay, slotLimit) {
                                      editAvailabilityBloc.onAddSlotClick(
                                          timeOfDay,
                                          slotLimit,
                                          editAvailabilityBloc,
                                          index);
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.add,
                                style: kSemiBoldThemeTextStyle.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: slots == null || slots.isEmpty ? 0 : 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: slots?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(
                                        right: 10, top: 7),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: ColorRes.smokeWhite3,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppRes.convert24HoursInto12Hours(
                                            slots?[index].time,
                                          ),
                                          style: kBoldThemeTextStyle.copyWith(
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          '${slots?[index].bookingLimit} ${AppLocalizations.of(context)!.slots}',
                                          style:
                                              kRegularEmpressTextStyle.copyWith(
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 6,
                                    child: CustomCircularInkWell(
                                      onTap: () {
                                        editAvailabilityBloc.deleteSlotBooking(
                                            slots?[index],
                                            editAvailabilityBloc);
                                      },
                                      child: ClipOval(
                                        child: Transform.rotate(
                                          angle: 45 * pi / 180,
                                          child: Container(
                                            color: ColorRes.charcoal,
                                            height: 18,
                                            child: const Image(
                                              image: AssetImage(
                                                AssetRes.icPlus_,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
