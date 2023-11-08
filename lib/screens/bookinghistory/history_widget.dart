import 'dart:ui';

import 'package:cutfx_salon/model/bookings/booking.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/ext/num_ext.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../requestDetails/request_detail_screen.dart';

class BookingHistoryWidget extends StatelessWidget {
  const BookingHistoryWidget({
    Key? key,
    required this.bookings,
  }) : super(key: key);
  final List<BookingData> bookings;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      primary: false,
      shrinkWrap: true,
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        BookingData bookingData = bookings[index];
        return ItemHistoryBooking(
          bookingData: bookingData,
        );
      },
    );
  }
}

class ItemHistoryBooking extends StatelessWidget {
  const ItemHistoryBooking({
    Key? key,
    required this.bookingData,
  }) : super(key: key);
  final BookingData bookingData;

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: () {
        Get.to(() => const RequestDetailsScreen(),
            arguments: bookingData.bookingId);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        margin: const EdgeInsets.only(bottom: 5),
        child: Column(
          children: [
            Container(
              color: ColorRes.smokeWhite,
              child: CustomCircularInkWell(
                onTap: () {
                  Get.to(() => const RequestDetailsScreen(), arguments: {
                    ConstRes.bookingId: bookingData.bookingId,
                    ConstRes.type: 1,
                  });
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 110,
                      height: 110,
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 110,
                            width: 110,
                            child: Image(
                              image: NetworkImage(
                                  '${ConstRes.itemBaseUrl}${bookingData.user?.profileImage}'),
                              fit: BoxFit.cover,
                              errorBuilder: errorBuilderForImage,
                              loadingBuilder: loadingImage,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: ClipRect(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 7,
                                ),
                                color: ColorRes.themeColor30,
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: Center(
                                    child: Text(
                                      AppRes.convert24HoursInto12Hours(
                                          bookingData.time),
                                      style: kSemiBoldTextStyle.copyWith(
                                        color: ColorRes.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
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
                            '${bookingData.user?.firstName?.capitalize}',
                            style: kSemiBoldTextStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${bookingData.services?.split(",").length} ${AppLocalizations.of(context)!.services}',
                            style: kThinWhiteTextStyle.copyWith(
                              color: ColorRes.black,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                (bookingData.payableAmount ?? 0).currency,
                                style: kSemiBoldThemeTextStyle,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  AppLocalizations.of(context)!.dash,
                                  style: kLightTextStyle.copyWith(
                                    color: ColorRes.themeColor,
                                  ),
                                ),
                              ),
                              Text(
                                AppRes.convertTimeForService(
                                    int.parse(bookingData.duration ?? '0'),context),
                                style: kLightTextStyle.copyWith(
                                  color: ColorRes.themeColor,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              alignment: Alignment.centerRight,
              color:
                  AppRes.getTextColorByStatus(bookingData.status?.toInt() ?? 0)
                      .withOpacity(.2),
              child: Text(
                AppRes.getTextByStatus(bookingData.status?.toInt() ?? 0),
                style: kRegularTextStyle.copyWith(
                  color: AppRes.getTextColorByStatus(
                      bookingData.status?.toInt() ?? 0),
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
