import 'dart:io';

import 'package:cutfx_salon/bloc/mysalon/my_salon_bloc.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/user/salon.dart';

class SalonDetailsPage extends StatelessWidget {
  const SalonDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MySalonBloc, MySalonState>(
      builder: (context, state) {
        Salon? salon;
        if (state is MySalonDataFetched) {
          salon = state.salon;
        }
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '${salon?.data?.salonAbout}',
                  style: kLightWhiteTextStyle.copyWith(
                    color: ColorRes.empress,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                color: ColorRes.smokeWhite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.contactDetail,
                      style: kSemiBoldThemeTextStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      salon?.data?.salonPhone ?? '',
                      style: kLightWhiteTextStyle.copyWith(
                        color: ColorRes.empress,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                color: ColorRes.smokeWhite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.availability,
                      style: kSemiBoldThemeTextStyle,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.mondayFriday,
                              style: kLightWhiteTextStyle.copyWith(
                                color: ColorRes.empress,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${AppRes.convert24HoursInto12Hours(salon?.data?.monFriFrom)}'
                              ' - '
                              '${AppRes.convert24HoursInto12Hours(salon?.data?.monFriTo)}',
                              style: kSemiBoldTextStyle.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          height: 1,
                          margin: const EdgeInsets.only(top: 15, bottom: 15),
                          color: ColorRes.smokeWhite1,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.saturdaySunday,
                          style: kLightWhiteTextStyle.copyWith(
                            color: ColorRes.empress,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${AppRes.convert24HoursInto12Hours(salon?.data?.satSunFrom)}'
                          ' - '
                          '${AppRes.convert24HoursInto12Hours(salon?.data?.satSunTo)}',
                          style: kSemiBoldTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              AspectRatio(
                aspectRatio: 1 / .6,
                child: Stack(
                  children: [
                    GMapDetails(salon: salon),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: CustomCircularInkWell(
                          onTap: () async {
                            String iosUrl =
                                'https://maps.apple.com/?q=${salon?.data?.salonLat},${salon?.data?.salonLong}';
                            if (Platform.isAndroid) {
                              String googleUrl =
                                  'https://www.google.com/maps/search/?api=1&query=${salon?.data?.salonLat},${salon?.data?.salonLong}';
                              if (await canLaunchUrl(Uri.parse(googleUrl))) {
                                await launchUrl(Uri.parse(googleUrl));
                              } else {
                                throw 'Could not launch $googleUrl';
                              }
                            } else {
                              if (await canLaunchUrl(Uri.parse(iosUrl))) {
                                await launchUrl(Uri.parse(iosUrl));
                              } else {
                                throw 'Could not open the map.';
                              }
                            }
                          },
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            child: Container(
                              color: ColorRes.themeColor,
                              width: 130,
                              height: 45,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Image(
                                      image: AssetImage(AssetRes.icNavigator),
                                      height: 24,
                                      width: 24,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.navigate,
                                      style: kRegularThemeTextStyle.copyWith(
                                        fontSize: 16,
                                        color: ColorRes.white,
                                      ),
                                    ),
                                  ],
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
            ],
          ),
        );
      },
    );
  }
}

class GMapDetails extends StatefulWidget {
  const GMapDetails({
    super.key,
    required this.salon,
  });

  final Salon? salon;

  @override
  State<GMapDetails> createState() => _GMapDetailsState();
}

class _GMapDetailsState extends State<GMapDetails> {
  BitmapDescriptor? bitmapDescriptor;
  Set<Marker> markers = {};
  late String mapStyle;
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return widget.salon != null
        ? GoogleMap(
            initialCameraPosition: CameraPosition(
              // target: LatLng(
              //   double.parse(widget.salon?.data?.salonLat ?? '0'),
              //   double.parse(widget.salon?.data?.salonLong ?? '0'),
              // ),
              target: LatLng(
                double.parse(widget.salon?.data?.salonLat ?? '0'),
                double.parse(widget.salon?.data?.salonLong ?? '0'),
              ),
              zoom: 12,
            ),
            onTap: null,
            onMapCreated: (controller) {
              if (bitmapDescriptor == null) {
                initBitmap(controller);
              }
            },
            zoomControlsEnabled: false,
            zoomGesturesEnabled: false,
            mapType: MapType.normal,
            myLocationButtonEnabled: false,
            buildingsEnabled: true,
            markers: markers,
            scrollGesturesEnabled: false,
          )
        : const SizedBox();
  }

  void initBitmap(GoogleMapController controller) async {
    mapStyle = await rootBundle.loadString('images/map_style.json');
    bitmapDescriptor = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(15, 15)), AssetRes.icPin);
    markers = Set.of(List.generate(1, (index) {
      return Marker(
        markerId: const MarkerId('q'),
        position: LatLng(
          double.parse(widget.salon?.data?.salonLat ?? '0'),
          double.parse(widget.salon?.data?.salonLong ?? '0'),
        ),
        icon: bitmapDescriptor!,
      );
    }));
    controller.setMapStyle(mapStyle);
    setState(() {});
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }
}

class RoundCornerWithImageWidget extends StatelessWidget {
  final String image;
  final Color? bgColor;
  final Color? imageColor;
  final double? imagePadding;
  final double? cornerRadius;
  final Function()? onTap;

  const RoundCornerWithImageWidget({
    Key? key,
    required this.image,
    this.imagePadding,
    this.cornerRadius,
    this.bgColor,
    this.imageColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor ?? ColorRes.themeColor5,
          borderRadius: BorderRadius.all(Radius.circular(cornerRadius ?? 10)),
        ),
        height: 45,
        width: 45,
        padding: EdgeInsets.all(imagePadding ?? 10),
        child: Image(
          image: AssetImage(
            image,
          ),
          color: imageColor,
        ),
      ),
    );
  }
}
