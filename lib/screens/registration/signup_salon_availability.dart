import 'package:cutfx_salon/bloc/singnup/sign_up_bloc.dart';
import 'package:cutfx_salon/bloc/singnup/sign_up_state.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpSalonAvailabilityWidget extends StatelessWidget {
  const SignUpSalonAvailabilityWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpBloc signUpBloc = context.watch<SignUpBloc>();
    return BlocBuilder<SignUpBloc, SignUpState>(
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
                      height: 30,
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
                              signUpBloc.onTimeClick(0, signUpBloc, context);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: ColorRes.smokeWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 15,
                              ),
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
                                    signUpBloc.monFriFrom == null ||
                                            signUpBloc.monFriFrom!.isEmpty
                                        ? '00:00'
                                        : signUpBloc.monFriFrom!,
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
                              signUpBloc.onTimeClick(1, signUpBloc, context);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: ColorRes.smokeWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 15,
                              ),
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
                                    signUpBloc.monFriTo == null ||
                                            signUpBloc.monFriTo!.isEmpty
                                        ? '00:00'
                                        : signUpBloc.monFriTo!,
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
                              signUpBloc.onTimeClick(2, signUpBloc, context);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: ColorRes.smokeWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 15,
                              ),
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
                                    signUpBloc.satSunFrom == null ||
                                            signUpBloc.satSunFrom!.isEmpty
                                        ? '00:00'
                                        : signUpBloc.satSunFrom!,
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
                              signUpBloc.onTimeClick(3, signUpBloc, context);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: ColorRes.smokeWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 15,
                              ),
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
                                    signUpBloc.satSunTo == null ||
                                            signUpBloc.satSunTo!.isEmpty
                                        ? '00:00'
                                        : signUpBloc.satSunTo!,
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
                    // Text(
                    //   AppLocalizations.of(context)!.addBookingSlotsByWeekDays,
                    //   style: kRegularTextStyle,
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    // Text(
                    //   AppLocalizations.of(context)!
                    //       .ifYouHaveAddedOnly2SlotsForMondayThen,
                    //   style:
                    //       kRegularTextStyle.copyWith(color: ColorRes.empress),
                    // ),
                  ],
                ),
              ),
              // ListView.builder(
              //   primary: false,
              //   itemCount: DateFormat().dateSymbols.WEEKDAYS.length,
              //   padding: const EdgeInsets.all(0),
              //   shrinkWrap: true,
              //   scrollDirection: Axis.vertical,
              //   itemBuilder: (context, index) {
              //     List<SlotData>? slots = signUpBloc
              //         .salonSlots[DateFormat().dateSymbols.WEEKDAYS[index]];
              //     return Container(
              //       color: ColorRes.smokeWhite2,
              //       margin: const EdgeInsets.only(top: 10),
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 15, vertical: 15),
              //       child: Column(
              //         children: [
              //           Row(
              //             children: [
              //               Text(
              //                 signUpBloc.salonSlots.keys
              //                     .toList()[index]
              //                     .toUpperCase(),
              //                 style: kSemiBoldTextStyle.copyWith(
              //                   fontSize: 14,
              //                   letterSpacing: 1.5,
              //                 ),
              //               ),
              //               const Spacer(),
              //               CustomCircularInkWell(
              //                 onTap: () {
              //                   if (signUpBloc.monFriFrom == null ||
              //                       signUpBloc.monFriTo == null ||
              //                       signUpBloc.satSunFrom == null ||
              //                       signUpBloc.satSunTo == null) {
              //                     AppRes.showSnackBar(
              //                         AppLocalizations.of(context)!
              //                             .pleaseCompleteAvailabilityFirst,
              //                         false);
              //                     return;
              //                   }
              //                   Get.bottomSheet(
              //                     AddSlotDialog(
              //                       nameOfDay: signUpBloc.salonSlots.keys
              //                           .toList()[index],
              //                       onTimeSlotClick: (timeSelect) {
              //                         signUpBloc.onSlotTimeClick(
              //                             index, timeSelect);
              //                       },
              //                       onClickSubmit: (timeOfDay, slotLimit) {
              //                         signUpBloc.onAddSlotClick(timeOfDay,
              //                             slotLimit, signUpBloc, index);
              //                       },
              //                     ),
              //                   );
              //                 },
              //                 child: Text(
              //                   AppLocalizations.of(context)!.add,
              //                   style: kSemiBoldThemeTextStyle.copyWith(
              //                     fontSize: 15,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //           SizedBox(
              //             height: slots == null || slots.isEmpty ? 0 : 50,
              //             child: ListView.builder(
              //               scrollDirection: Axis.horizontal,
              //               itemCount: slots?.length ?? 0,
              //               itemBuilder: (context, index) {
              //                 return Stack(
              //                   children: [
              //                     Container(
              //                       width: 100,
              //                       margin: const EdgeInsets.only(
              //                           right: 10, top: 7),
              //                       padding: const EdgeInsets.symmetric(
              //                         horizontal: 10,
              //                       ),
              //                       decoration: const BoxDecoration(
              //                         color: ColorRes.smokeWhite3,
              //                         borderRadius:
              //                         BorderRadius.all(Radius.circular(5)),
              //                       ),
              //                       child: Column(
              //                         crossAxisAlignment:
              //                         CrossAxisAlignment.start,
              //                         mainAxisAlignment:
              //                         MainAxisAlignment.center,
              //                         children: [
              //                           Text(
              //                             AppRes.convert24HoursInto12Hours(
              //                               slots?[index].time,
              //                             ),
              //                             style: kBoldThemeTextStyle.copyWith(
              //                               fontSize: 15,
              //                             ),
              //                           ),
              //                           const SizedBox(
              //                             height: 2,
              //                           ),
              //                           Text(
              //                             '${slots?[index].bookingLimit} ${AppLocalizations.of(context)!.slots}',
              //                             style:
              //                             kRegularEmpressTextStyle.copyWith(
              //                               fontSize: 13,
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                     Positioned(
              //                       right: 6,
              //                       child: CustomCircularInkWell(
              //                         onTap: () {
              //                           signUpBloc.deleteSlotBooking(
              //                               slots?[index], signUpBloc);
              //                         },
              //                         child: ClipOval(
              //                           child: Transform.rotate(
              //                             angle: 45 * pi / 180,
              //                             child: Container(
              //                               color: ColorRes.charcoal,
              //                               height: 18,
              //                               child: const Image(
              //                                 image: AssetImage(
              //                                   AssetRes.icPlus_,
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 );
              //               },
              //             ),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }
}

class AddSlotDialog extends StatefulWidget {
  final String nameOfDay;
  final Function(Function(TimeOfDay? time) timeSelect) onTimeSlotClick;
  final Function(TimeOfDay? time, int slotLimit) onClickSubmit;

  const AddSlotDialog({
    super.key,
    required this.nameOfDay,
    required this.onTimeSlotClick,
    required this.onClickSubmit,
  });

  @override
  State<AddSlotDialog> createState() => _AddSlotDialogState();
}

class _AddSlotDialogState extends State<AddSlotDialog> {
  int selectedSlotCount = 1;
  String? time;
  TimeOfDay? timeOfDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${AppLocalizations.of(context)!.addSlot} (${widget.nameOfDay})',
                style: kBoldThemeTextStyle,
              ),
              const Spacer(),
              CloseButtonWidget(
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.selectTime,
                      style: kLightTextStyle.copyWith(
                        color: ColorRes.mortar,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        widget.onTimeSlotClick(
                          (time) {
                            if (time == null) return;
                            timeOfDay = time;
                            this.time =
                                '${0.convert2Digits(time.hourOfPeriod)}:${0.convert2Digits(time.minute)} ${time.period.name.toUpperCase()}';
                            setState(() {});
                          },
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: ColorRes.smokeWhite,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              time ?? '00:00',
                              style: kLightTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Slot Limit',
                      style: kLightTextStyle.copyWith(
                        color: ColorRes.mortar,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: ColorRes.smokeWhite,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: const EdgeInsets.only(top: 8),
                      child: DropdownButton<int>(
                        value: selectedSlotCount,
                        padding: const EdgeInsets.all(0),
                        dropdownColor: ColorRes.white,
                        borderRadius: BorderRadius.circular(10),
                        menuMaxHeight: 350,
                        underline: const SizedBox(),
                        items: List.generate(AppRes.limitOfSlots, (index) {
                          return DropdownMenuItem<int>(
                            value: index + 1,
                            child: Container(
                              width: 150,
                              height: 100,
                              margin: const EdgeInsets.symmetric(vertical: 2.5),
                              decoration: const BoxDecoration(
                                color: ColorRes.smokeWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${index + 1}',
                                    style: kLightTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        onChanged: (value) {
                          selectedSlotCount = value ?? 1;
                          setState(() {});
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          const Spacer(),
          SafeArea(
            top: false,
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: TextButton(
                onPressed: () {
                  widget.onClickSubmit(timeOfDay, selectedSlotCount);
                },
                style: kButtonThemeStyle,
                child: Text(
                  AppLocalizations.of(context)!.submit,
                  style: kBlackButtonTextStyle.copyWith(
                    color: ColorRes.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
