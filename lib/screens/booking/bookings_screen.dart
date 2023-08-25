import 'dart:ui';

import 'package:cutfx_salon/bloc/bookings/bookings_bloc.dart';
import 'package:cutfx_salon/model/bookings/booking.dart';
import 'package:cutfx_salon/screens/booking/widget/bookings_top.dart';
import 'package:cutfx_salon/screens/qrScan/qr_scan_screen.dart';
import 'package:cutfx_salon/screens/requestDetails/request_detail_screen.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/ext/num_ext.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingsBloc(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.dialog(const QrScanScreen());
          },
          backgroundColor: ColorRes.themeColor,
          child: const Image(
            image: AssetImage(
              AssetRes.icScan,
            ),
            height: 30,
          ),
        ),
        body: BlocBuilder<BookingsBloc, BookingsState>(
          builder: (context, state) {
            BookingsBloc bookingsBloc = context.read<BookingsBloc>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookingsTopWidget(
                  onDoneClick: (month, year) {
                    bookingsBloc.add(MonthSelectBookingEvent(month, year));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TableCalendar(
                  firstDay:
                      DateTime.utc(bookingsBloc.year, bookingsBloc.month, 1),
                  lastDay: DateTime.utc(
                      bookingsBloc.year,
                      bookingsBloc.month,
                      DateTime.utc(bookingsBloc.year, bookingsBloc.month + 1, 0)
                          .day),
                  focusedDay: DateTime.utc(
                      bookingsBloc.year, bookingsBloc.month, bookingsBloc.day),
                  currentDay: DateTime.utc(
                      bookingsBloc.year, bookingsBloc.month, bookingsBloc.day),
                  calendarFormat: CalendarFormat.week,
                  headerVisible: false,
                  shouldFillViewport: false,
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  calendarStyle: const CalendarStyle(
                    cellMargin: EdgeInsets.all(0),
                    cellPadding: EdgeInsets.all(0),
                  ),
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      return AspectRatio(
                        aspectRatio: 1 / 1.2,
                        child: CustomCircularInkWell(
                          onTap: () {
                            bookingsBloc.add(
                              DateSelectBookingEvent(
                                day.day,
                                day.month,
                                day.year,
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorRes.smokeWhite,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              color: ColorRes.transparent,
                              dashPattern: const [2],
                              radius: const Radius.circular(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    day.day.toString(),
                                    style: kBoldThemeTextStyle.copyWith(
                                      fontSize: 20,
                                      color: ColorRes.empress,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('EE').format(day).toUpperCase(),
                                    style: kRegularThemeTextStyle.copyWith(
                                      color: ColorRes.empress,
                                      fontSize: 12,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: double.infinity,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    selectedBuilder: (context, day, focusedDay) {
                      return AspectRatio(
                        aspectRatio: 1 / 1.2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorRes.smokeWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            color: ColorRes.transparent,
                            dashPattern: const [2],
                            radius: const Radius.circular(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  day.day.toString(),
                                  style: kBoldThemeTextStyle.copyWith(
                                    fontSize: 20,
                                    color: ColorRes.empress,
                                  ),
                                ),
                                Text(
                                  DateFormat('EE').format(day).toUpperCase(),
                                  style: kRegularThemeTextStyle.copyWith(
                                    color: ColorRes.empress,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(
                                  width: double.infinity,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    todayBuilder: (context, day, focusedDay) {
                      return AspectRatio(
                        aspectRatio: 1 / 1.2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorRes.lavender,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            color: ColorRes.themeColor,
                            dashPattern: const [2],
                            radius: const Radius.circular(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  day.day.toString(),
                                  style: kBoldThemeTextStyle.copyWith(
                                    fontSize: 20,
                                    color: ColorRes.themeColor,
                                  ),
                                ),
                                Text(
                                  DateFormat('EE').format(day).toUpperCase(),
                                  style: kRegularThemeTextStyle.copyWith(
                                    color: ColorRes.themeColor,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(
                                  width: double.infinity,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    disabledBuilder: (context, day, focusedDay) {
                      return AspectRatio(
                        aspectRatio: 1 / 1.2,
                        child: CustomCircularInkWell(
                          onTap: () {
                            bookingsBloc.add(
                              DateSelectBookingEvent(
                                day.day,
                                day.month,
                                day.year,
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorRes.smokeWhite,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              color: ColorRes.transparent,
                              dashPattern: const [2],
                              radius: const Radius.circular(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    day.day.toString(),
                                    style: kBoldThemeTextStyle.copyWith(
                                      fontSize: 20,
                                      color: ColorRes.empress,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('EE').format(day).toUpperCase(),
                                    style: kRegularThemeTextStyle.copyWith(
                                      color: ColorRes.empress,
                                      fontSize: 12,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: double.infinity,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  daysOfWeekHeight: 0,
                ),
                SizedBox(
                  height: 0,
                  child: ListView.builder(
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: index == 0
                              ? ColorRes.lavender
                              : ColorRes.smokeWhite,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: AspectRatio(
                          aspectRatio: 0.75 / 1,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            color: index == 0
                                ? ColorRes.themeColor
                                : ColorRes.transparent,
                            dashPattern: const [2],
                            radius: const Radius.circular(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${24 + index}',
                                  style: kBoldThemeTextStyle.copyWith(
                                    fontSize: 24,
                                    color: index == 0
                                        ? ColorRes.themeColor
                                        : ColorRes.empress,
                                  ),
                                ),
                                Text(
                                  'WED',
                                  style: kRegularThemeTextStyle.copyWith(
                                    color: index == 0
                                        ? ColorRes.themeColor
                                        : ColorRes.empress,
                                    fontSize: 14,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(
                                  width: double.infinity,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    '${state is DateSelectBookingState ? state.list.length : 0} ${AppLocalizations.of(context)!.appointments}',
                    style: kRegularTextStyle,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorRes.smokeWhite,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(context)!.search,
                      hintStyle: kLightTextStyle.copyWith(
                        color: ColorRes.empress,
                      ),
                    ),
                    style: kRegularTextStyle.copyWith(
                      color: ColorRes.charcoal50,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                Expanded(
                  child: BlocBuilder<BookingsBloc, BookingsState>(
                    builder: (context, state) {
                      if (state is DateSelectBookingState) {
                        return state.list.isNotEmpty
                            ? ListView.builder(
                                itemCount: state.list.length,
                                padding: const EdgeInsets.all(0),
                                itemBuilder: (context, index) {
                                  BookingData data = state.list[index];
                                  return ItemBookings(data);
                                },
                              )
                            : const Center(child: DataNotFound());
                      }
                      return const Center(
                          child: LoadingData(
                        color: Colors.white,
                      ));
                    },
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

class ItemBookings extends StatelessWidget {
  final BookingData data;

  const ItemBookings(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorRes.smokeWhite,
      margin: const EdgeInsets.only(bottom: 5),
      child: CustomCircularInkWell(
        onTap: () {
          Get.to(() => const RequestDetailsScreen(), arguments: {
            ConstRes.bookingId: data.bookingId,
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
                          '${ConstRes.itemBaseUrl}${data.user?.profileImage}'),
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
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Center(
                            child: Text(
                              AppRes.convert24HoursInto12Hours(data.time),
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
                    '${data.user?.fullname?.capitalize}',
                    style: kSemiBoldTextStyle.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${data.services?.length} ${AppLocalizations.of(context)!.services}',
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
                        (data.payableAmount ?? 0).currency,
                        style: kSemiBoldThemeTextStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          AppLocalizations.of(context)!.dash,
                          style: kLightTextStyle.copyWith(
                            color: ColorRes.themeColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          AppRes.convertTimeForService(
                              int.parse(data.duration ?? '0')),
                          style: kLightTextStyle.copyWith(
                            color: ColorRes.themeColor,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorRes.smokeWhite1,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        child: Text(
                          AppLocalizations.of(context)!.callNow,
                          style: kRegularTextStyle.copyWith(
                            color: ColorRes.themeColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
