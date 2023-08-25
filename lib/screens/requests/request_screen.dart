import 'package:cutfx_salon/bloc/requests/request_bloc.dart';
import 'package:cutfx_salon/model/bookings/booking.dart';
import 'package:cutfx_salon/screens/requestDetails/request_detail_screen.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/ext/num_ext.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestBloc(),
      child: Column(
        children: [
          Container(
            color: ColorRes.themeColor5,
            width: double.infinity,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Text(
                  AppLocalizations.of(context)!.bookingRequests,
                  style: kRegularThemeTextStyle.copyWith(
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<RequestBloc, RequestState>(
              builder: (context, state) {
                if (state is FetchedRequestState) {
                  return state.requests.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.only(top: 10),
                          itemCount: state.requests.length,
                          itemBuilder: (context, index) {
                            BookingData data = state.requests[index];
                            return ItemBookingRequest(
                              data: data,
                              onUpdate: () {
                                context
                                    .read<RequestBloc>()
                                    .add(GetRequestsEvent());
                              },
                            );
                          },
                        )
                      : const Center(child: DataNotFound());
                }
                return const Center(child: LoadingData());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ItemBookingRequest extends StatelessWidget {
  final BookingData data;
  final Function() onUpdate;

  const ItemBookingRequest(
      {Key? key, required this.data, required this.onUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: () {
        Get.to(() => const RequestDetailsScreen(), arguments: {
          ConstRes.bookingId: data.bookingId,
          ConstRes.type: 0,
        });
      },
      child: Container(
        color: ColorRes.smokeWhite2,
        margin: const EdgeInsets.only(bottom: 5),
        child: AspectRatio(
          aspectRatio: 1 / .25,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 0.85 / 1,
                child: Image(
                  image: NetworkImage(
                      '${ConstRes.itemBaseUrl}${data.user?.profileImage ?? ''}'),
                  fit: BoxFit.cover,
                  errorBuilder: errorBuilderForImage,
                  loadingBuilder: loadingImage,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${AppRes.formatDate(
                        AppRes.parseDate(
                          data.date ?? '',
                          pattern: 'yyyy-MM-dd',
                          isUtc: false,
                        ),
                        pattern: 'dd MMM, yyyy - EE',
                        isUtc: false,
                      )} - ${AppRes.convert24HoursInto12Hours(data.time)}',
                      style: kLightTextStyle.copyWith(
                        color: ColorRes.empress,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      data.user?.fullname?.capitalize ?? '',
                      style: kSemiBoldTextStyle.copyWith(
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // Text(
                    //   '${data.services?.length ?? 0} ${AppLocalizations.of(context)!.services}',
                    //   style: kThinWhiteTextStyle.copyWith(
                    //     color: ColorRes.black,
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
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
                        Text(
                          AppRes.convertTimeForService(
                            int.parse(data.duration ?? '0'),
                          ),
                          style: kLightTextStyle.copyWith(
                            color: ColorRes.themeColor,
                            fontSize: 14,
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
    );
  }
}
