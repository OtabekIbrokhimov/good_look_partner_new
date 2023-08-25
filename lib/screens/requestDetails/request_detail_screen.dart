import 'dart:math';

import 'package:cutfx_salon/bloc/requestdetails/request_details_bloc.dart';
import 'package:cutfx_salon/model/order_summary.dart';
import 'package:cutfx_salon/model/request/request_details.dart';
import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/screens/booking/widget/complete_booking_sheet.dart';
import 'package:cutfx_salon/screens/main/main_screen.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/ext/num_ext.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as url;

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({Key? key}) : super(key: key);

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  bool rateIsGave = false;
  bool orderIsStart = Random().nextBool();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestDetailsBloc(),
      child: Scaffold(
        body: BlocBuilder<RequestDetailsBloc, RequestDetailsState>(
          builder: (context, state) {
            RequestDetails? requestDetails =
                state is RequestDetailFoundState ? state.requestDetails : null;

            return Column(
              children: [
                Container(
                  color: ColorRes.smokeWhite,
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 15),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomCircularInkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Image(
                              image: AssetImage(AssetRes.icBack),
                              height: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .bookingDetails,
                                    style: kBoldThemeTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    requestDetails?.data?.bookingId ?? '',
                                    style: kRegularTextStyle.copyWith(
                                      fontSize: 14,
                                      color: ColorRes.empress,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        (requestDetails?.data?.payableAmount ??
                                                0)
                                            .currency,
                                        style: kRegularThemeTextStyle.copyWith(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Text(
                                          AppLocalizations.of(context)!.dash,
                                          style: kLightWhiteTextStyle.copyWith(
                                            color: ColorRes.themeColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        AppRes.convertTimeForService(int.parse(
                                            requestDetails?.data?.duration ??
                                                '0')),
                                        style: kLightTextStyle.copyWith(
                                          color: ColorRes.themeColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                requestDetails == null
                    ? const Expanded(
                        child: Center(
                          child: LoadingData(
                            color: ColorRes.white,
                          ),
                        ),
                      )
                    : Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 15,
                                      ),
                                      color: AppRes.getColorByStatus(
                                          requestDetails.data?.status
                                                  ?.toInt() ??
                                              0),
                                      child: Text(
                                        AppRes.getTextByStatus(requestDetails
                                                .data?.status
                                                ?.toInt() ??
                                            0),
                                        style: kRegularTextStyle.copyWith(
                                          color: AppRes.getTextColorByStatus(
                                              requestDetails.data?.status
                                                      ?.toInt() ??
                                                  0),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    AspectRatio(
                                      aspectRatio: 1 / .25,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: ColorRes.smokeWhite,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Row(
                                          children: [
                                            AspectRatio(
                                              aspectRatio: 1 / 1,
                                              child: Image(
                                                image: NetworkImage(
                                                    '${ConstRes.itemBaseUrl}${requestDetails.data?.user?.profileImage}'),
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    errorBuilderForImage,
                                                loadingBuilder: loadingImage,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                  left: 15,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      requestDetails
                                                              .data
                                                              ?.user
                                                              ?.fullname
                                                              ?.capitalize ??
                                                          '',
                                                      style: kSemiBoldTextStyle
                                                          .copyWith(
                                                        color: ColorRes.nero,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      requestDetails.data?.user
                                                              ?.phoneNumber ??
                                                          '',
                                                      style: kThinWhiteTextStyle
                                                          .copyWith(
                                                        color:
                                                            ColorRes.titleText,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            BgRoundImageWidget(
                                              image: AssetRes.icCall,
                                              bgColor: ColorRes.smokeWhite1,
                                              imagePadding: 10,
                                              height: 45,
                                              width: 45,
                                              onTap: () {
                                                url.launchUrl(Uri.parse(
                                                    'tel:${requestDetails.data?.user?.phoneNumber}'));
                                              },
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: ColorRes.smokeWhite2,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .date,
                                                      style:
                                                          kLightWhiteTextStyle
                                                              .copyWith(
                                                        color: ColorRes.empress,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      AppRes.formatDate(
                                                        AppRes.parseDate(
                                                          requestDetails
                                                                  .data?.date ??
                                                              '',
                                                          pattern: 'yyyy-MM-dd',
                                                          isUtc: false,
                                                        ),
                                                        pattern: 'dd MMM, yyyy',
                                                        isUtc: false,
                                                      ),
                                                      style:
                                                          kRegularThemeTextStyle
                                                              .copyWith(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .time,
                                                      style:
                                                          kLightWhiteTextStyle
                                                              .copyWith(
                                                        color: ColorRes.empress,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      AppRes
                                                          .convert24HoursInto12Hours(
                                                              requestDetails
                                                                  .data?.time),
                                                      style:
                                                          kRegularThemeTextStyle
                                                              .copyWith(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .duration,
                                                      style:
                                                          kLightWhiteTextStyle
                                                              .copyWith(
                                                        color: ColorRes.empress,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      AppRes.convertTimeForService(
                                                          int.parse(requestDetails
                                                                  .data
                                                                  ?.duration ??
                                                              '0')),
                                                      style:
                                                          kRegularThemeTextStyle
                                                              .copyWith(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 20,
                                              bottom: 10,
                                            ),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .services,
                                              style:
                                                  kLightWhiteTextStyle.copyWith(
                                                color: ColorRes.empress,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: List<Widget>.generate(
                                              requestDetails
                                                      .data?.services?.length ??
                                                  0,
                                              (index) {
                                                Services? serviceData =
                                                    requestDetails
                                                        .data?.services?[index];
                                                return Container(
                                                  color: ColorRes.smokeWhite,
                                                  margin: const EdgeInsets.only(
                                                      bottom: 5),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            serviceData
                                                                    ?.title ??
                                                                '',
                                                            style:
                                                                kRegularTextStyle
                                                                    .copyWith(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 2,
                                                          ),
                                                          Text(
                                                            '${serviceData?.category?.title} | ${AppRes.convertTimeForService(serviceData?.serviceTime ?? 0)}',
                                                            style:
                                                                kLightTextStyle
                                                                    .copyWith(
                                                              color: ColorRes
                                                                  .themeColor,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        ((serviceData?.price
                                                                        ?.toInt() ??
                                                                    0) -
                                                                AppRes.calculateDiscountByPercentage(
                                                                        serviceData?.price?.toInt() ??
                                                                            0,
                                                                        serviceData?.discount?.toInt() ??
                                                                            0)
                                                                    .toInt())
                                                            .currency,
                                                        style:
                                                            kSemiBoldThemeTextStyle
                                                                .copyWith(
                                                          fontSize: 18,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Visibility(
                                            visible: requestDetails.data
                                                    ?.getOrderSummary()
                                                    .coupon !=
                                                null,
                                            child: Container(
                                              color: ColorRes.smokeWhite,
                                              margin: const EdgeInsets.only(
                                                  bottom: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .couponDiscount,
                                                        style: kRegularTextStyle
                                                            .copyWith(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: ColorRes
                                                              .smokeWhite1,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10,
                                                                vertical: 3),
                                                        child: Text(
                                                          (requestDetails.data
                                                                      ?.getOrderSummary()
                                                                      .coupon
                                                                      ?.coupon ??
                                                                  '')
                                                              .toUpperCase(),
                                                          style:
                                                              kBoldThemeTextStyle
                                                                  .copyWith(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    '-${(requestDetails.data?.getOrderSummary().discountAmount ?? 0).currency}',
                                                    style:
                                                        kSemiBoldThemeTextStyle
                                                            .copyWith(
                                                      fontSize: 18,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: ColorRes.lavender,
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 15),
                                            child: Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .subTotal,
                                                  style: kRegularTextStyle
                                                      .copyWith(
                                                    fontSize: 16,
                                                    color: ColorRes.themeColor,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  (requestDetails.data
                                                              ?.getOrderSummary()
                                                              .subtotal ??
                                                          0)
                                                      .currency,
                                                  style: kSemiBoldThemeTextStyle
                                                      .copyWith(
                                                    fontSize: 18,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: List<Widget>.generate(
                                                requestDetails.data
                                                        ?.getOrderSummary()
                                                        .taxes
                                                        ?.length ??
                                                    0, (index) {
                                              Taxes? tax = requestDetails.data
                                                  ?.getOrderSummary()
                                                  .taxes?[index];
                                              return Container(
                                                color: ColorRes.smokeWhite,
                                                margin: const EdgeInsets.only(
                                                    bottom: 5),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 15),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      tax?.taxTitle ?? '',
                                                      style: kRegularTextStyle
                                                          .copyWith(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      (tax?.taxAmount ?? 0)
                                                          .currency,
                                                      style:
                                                          kSemiBoldThemeTextStyle
                                                              .copyWith(
                                                        fontSize: 18,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                          ),
                                          Container(
                                            color: ColorRes.charcoal,
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 15,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .totalAmount,
                                                  style: kRegularTextStyle
                                                      .copyWith(
                                                    fontSize: 16,
                                                    color: ColorRes.white,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  (requestDetails.data
                                                              ?.payableAmount ??
                                                          0)
                                                      .currency,
                                                  style: kSemiBoldThemeTextStyle
                                                      .copyWith(
                                                    fontSize: 18,
                                                    color: ColorRes.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SafeArea(
                              top: false,
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: requestDetails.data?.status == 0,
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: CustomCircularInkWell(
                                            onTap: () {
                                              context
                                                  .read<RequestDetailsBloc>()
                                                  .rejectBooking();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: ColorRes.bitterSweet10,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .decline,
                                                style: kRegularThemeTextStyle
                                                    .copyWith(
                                                  color: ColorRes.bitterSweet,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: CustomCircularInkWell(
                                            onTap: () {
                                              context
                                                  .read<RequestDetailsBloc>()
                                                  .acceptBooking();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: ColorRes.green10,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15,
                                              ),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .accept,
                                                style: kRegularThemeTextStyle
                                                    .copyWith(
                                                  color: ColorRes.green,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: requestDetails.data?.status == 1,
                                    child: CustomCircularInkWell(
                                      onTap: () {
                                        Get.bottomSheet(CompleteBookingSheet(
                                          requestDetails: requestDetails,
                                        )).then((value) {
                                          Get.back();
                                        });
                                      },
                                      child: Container(
                                        color: ColorRes.green10,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 18),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .markCompleted,
                                          style:
                                              kRegularThemeTextStyle.copyWith(
                                            color: ColorRes.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
