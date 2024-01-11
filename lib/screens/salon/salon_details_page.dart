import 'dart:io';

import 'package:cutfx_salon/bloc/mysalon/my_salon_bloc.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:location/location.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

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
                            final availableMaps =
                                await MapLauncher.installedMaps;
                            Get.bottomSheet(MapChoiceBottomSheet(
                              coords: Coords(
                                  double.parse(salon?.data?.salonLat ?? "0"),
                                  double.parse(salon?.data?.salonLong ?? '0')),
                              availableMaps: availableMaps,
                            ));
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
  late String mapStyle;
  final List<MapObject> mapObjects = [];

  Position? position;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      mapObjects.add(PlacemarkMapObject(
        onDrag: (obj, point) {},
        opacity: 1,
        mapId: const MapObjectId('salonll'),
        onTap: (icon, point) {
          yandexMapController
              .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: Point(
                latitude: double.parse(widget.salon?.data?.salonLat ?? "0"),
                longitude: double.parse(widget.salon?.data?.salonLong ?? "0")),
            zoom: 16.0,
          )));
        },
        point: Point(
            latitude: double.parse(widget.salon?.data?.salonLat ?? "0"),
            longitude: double.parse(widget.salon?.data?.salonLong ?? "0")),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            scale: 0.15,
            image: BitmapDescriptor.fromAssetImage(
              'images/map_salon_icon.png',
            ))),
      ));
    });
    Get.log(mapObjects.length.toString());
    //
    findUser();
    super.initState();
  }

  void findUser() async {
    Location location = Location();
    bool _serviceEnabled = false;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }
    setState(() async {
      position = await Geolocator.getCurrentPosition();
      Get.log("${position?.latitude ?? 0} ${position?.longitude ?? 0} + maaa");
    });
    // _addPlacemarkUser(position!);
  }

  @override
  Widget build(BuildContext context) {
    return widget.salon != null
        ? YandexMap(
            tiltGesturesEnabled: true,
            zoomGesturesEnabled: true,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            modelsEnabled: true,
            nightModeEnabled: false,
            mapObjects: mapObjects,
            onMapTap: (Point point) {
              // markers(
              //     latitude: point.latitude.toDouble(),
              //     longitude: point.longitude.toDouble());
            },
            onMapCreated: (YandexMapController yandexMapController) async {
              setState(() {
                mapObjects.add(PlacemarkMapObject(
                  onDrag: (obj, point) {},
                  opacity: 1,
                  mapId: const MapObjectId('useration'),
                  onTap: (icon, point) {
                    //_onTapChayxanaSortClear();
                    yandexMapController.moveCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target: Point(
                                latitude: point.latitude ?? 41.344517,
                                longitude: point.longitude ?? 69.2714301),
                            zoom: 100.0)));
                  },
                  point: Point(
                      latitude: position?.latitude ?? 41.344517,
                      longitude: position?.longitude ?? 69.2714332),
                  icon: PlacemarkIcon.single(PlacemarkIconStyle(
                      scale: 0.15,
                      image: BitmapDescriptor.fromAssetImage(
                        'images/person_location.png',
                      ))),
                ));
              });
              final cameraPosition =
                  await yandexMapController.getCameraPosition().then(
                (value) async {
                  await yandexMapController
                      .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
                          target: Point(
                            latitude: double.parse(
                                widget.salon?.data?.salonLat ?? '0'),
                            longitude: double.parse(
                                widget.salon?.data?.salonLong ?? '0'),
                          ),
                          zoom: 12.0)));
                },
              );
              //  determinePosition();
            },
          )
        // GoogleMap(
        //         initialCameraPosition: CameraPosition(
        //           // target: LatLng(
        //           //   double.parse(widget.salon?.data?.salonLat ?? '0'),
        //           //   double.parse(widget.salon?.data?.salonLong ?? '0'),
        //           // ),
        //           target: LatLng(
        //             double.parse(widget.salon?.data?.salonLat ?? '0'),
        //             double.parse(widget.salon?.data?.salonLong ?? '0'),
        //           ),
        //           zoom: 12,
        //         ),
        //         onTap: null,
        //         onMapCreated: (controller) {
        //           if (bitmapDescriptor == null) {
        //             initBitmap(controller);
        //           }
        //         },
        //         zoomControlsEnabled: false,
        //         zoomGesturesEnabled: false,
        //         mapType: MapType.normal,
        //         myLocationButtonEnabled: false,
        //         buildingsEnabled: true,
        //         markers: markers,
        //         scrollGesturesEnabled: false,
        //       )
        : const SizedBox();
  }

  late YandexMapController yandexMapController;

  // Future<void> determinePosition() async {
  //   setState(() async{
  //     Location location = Location();
  //
  //     bool _serviceEnabled;
  //     PermissionStatus _permissionGranted;
  //     LocationData _locationData;
  //
  //     _serviceEnabled = await location.serviceEnabled();
  //     if (!_serviceEnabled) {
  //       _serviceEnabled = await location.requestService();
  //       if (!_serviceEnabled) {
  //         return Future.error('Location services are disabled.');
  //       }
  //     }
  //
  //     _permissionGranted = await location.hasPermission();
  //     if (_permissionGranted == PermissionStatus.denied) {
  //       _permissionGranted = await location.requestPermission();
  //       if (_permissionGranted != PermissionStatus.granted) {
  //         return Future.error('Location services are disabled.');
  //       }
  //     }
  //   final _location  = await loc.Geolocator.getCurrentPosition(desiredAccuracy: loc.LocationAccuracy.high);
  //  position = _location;
  //   await yandexMapController.getCameraPosition().then(
  //     (value) async {
  //       await yandexMapController.moveCamera(
  //           yandex.CameraUpdate.newCameraPosition(yandex.CameraPosition(
  //               target: yandex.Point(
  //                   latitude: position!.latitude,
  //                   longitude: position!.longitude),
  //               zoom: 13.0)));
  //     },
  //   );
  //   await _addPlacemarkUser(position!);
  //  });
  // }

  // _addPlacemarkUser(Position position) async {
  //   setState(() async{

  //
  //
  //       await yandexMapController.getCameraPosition().then(
  //     (value) async {
  //       await yandexMapController.moveCamera(
  //           CameraUpdate.newCameraPosition(
  //               CameraPosition(
  //                   target: Point(
  //                     latitude: position.latitude,
  //                     longitude: position.longitude
  //                   ),
  //                   zoom: 12.0)));
  //     },
  //   );
  //   });
  // }

  // initBitmap(GoogleMapController controller) async {
  //   mapStyle = await rootBundle.loadString('images/map_style.json');
  //   bitmapDescriptor = await BitmapDescriptor.fromAssetImage(
  //       const ImageConfiguration(size: Size(15, 15)), AssetRes.icPin);
  //   markers = Set.of(List.generate(1, (index) {
  //     return Marker(
  //       markerId: const MarkerId('q'),
  //       position: LatLng(
  //         double.parse(widget.salon?.data?.salonLat ?? '0'),
  //         double.parse(widget.salon?.data?.salonLong ?? '0'),
  //       ),
  //       icon: bitmapDescriptor!,
  //     );
  //   }));
  //   controller.setMapStyle(mapStyle);
  //   setState(() {});
  // }

  @override
  void dispose() {
    // mapController?.dispose();
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

class MapChoiceBottomSheet extends StatelessWidget {
  final Coords coords;
  final List<AvailableMap> availableMaps;

  const MapChoiceBottomSheet({
    Key? key,
    required this.coords,
    required this.availableMaps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        width: Get.width,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Wrap(
          children: [
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                children: [
                  const Text(
                    "Open with",
                    style: kBoldThemeTextStyle,
                  ),
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () {
                        map.showMarker(
                          coords: coords,
                          title: "",
                        );
                        Get.log(map.mapName.split(" ").first);
                      },
                      title: Text(map.mapName),
                      leading: Image(
                        height: 55,
                        width:
                            map.mapName.split(" ").first == "Yandex" ? 45 : 55,
                        image: AssetImage(
                          map.mapName.split(" ").first == "Yandex"
                              ? "images/yandex_map.png"
                              : "images/google_map.png",
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  )
                  // const Text("Open with",style: kBoldThemeTextStyle,),
                  // Row(children: [
                  //   const SizedBox(width: 10,),
                  //   InkWell(
                  //     onTap: ()async{
                  //       String iosUrl =
                  //           'https://maps.apple.com/?q=$lang,$long';
                  //       if (Platform.isAndroid) {
                  //         String googleUrl =
                  //             'https://www.google.com/maps/search/?api=1&query=$lang,$long';
                  //         if (await canLaunchUrl(Uri.parse(googleUrl))) {
                  //           await launchUrl(Uri.parse(googleUrl));
                  //         } else {
                  //           throw 'Could not launch $googleUrl';
                  //         }
                  //       } else {
                  //         if (await canLaunchUrl(Uri.parse(iosUrl))) {
                  //           launchUrl(
                  //             Uri.parse('https://maps.apple.com/?q=$lang,$long'),
                  //             mode: LaunchMode.externalApplication,
                  //           );
                  //         } else {
                  //           throw 'Could not open the map.';
                  //         }
                  //       }
                  //     },
                  //     child: Column(
                  //     children: [
                  //       Container(
                  //         height: 60,
                  //         width: 60,
                  //         decoration:  BoxDecoration(
                  //           borderRadius: BorderRadius.circular(5),
                  //           image:const DecorationImage(
                  //             image: AssetImage(
                  //                 "images/google_map.png",
                  //             ),fit: BoxFit.cover
                  //           )
                  //         ),
                  //       ),
                  //       Text("MAPS".tr,style: kBoldThemeTextStyle.copyWith(fontSize: 10)),
                  //
                  //     ],
                  //                     ),
                  //   ),
                  //   const SizedBox(width: 10,),
                  //   InkWell(
                  //       onTap: ()async{
                  //         String iosUrl =
                  //             'https://maps.apple.com/?q=$lang,$long';
                  //         if (Platform.isAndroid) {
                  //           String googleUrl =
                  //               'https://www.google.com/maps/search/?api=1&query=$lang,$long';
                  //           if (await canLaunchUrl(Uri.parse(googleUrl))) {
                  //             await launchUrl(Uri.parse(googleUrl));
                  //           } else {
                  //             throw 'Could not launch $googleUrl';
                  //           }
                  //         } else {
                  //           if (await canLaunchUrl(Uri.parse(iosUrl))) {
                  //             launchUrl(
                  //               Uri.parse('https://maps.apple.com/?q=$lang,$long'),
                  //               mode: LaunchMode.externalApplication,
                  //             );
                  //           } else {
                  //             throw 'Could not open the map.';
                  //           }
                  //         }
                  //       },
                  //       child:  Column(
                  //     children: [
                  //       Container(
                  //         height: 60,
                  //         width: 60,
                  //         decoration:  BoxDecoration(
                  //             borderRadius: BorderRadius.circular(5),
                  //             image:const DecorationImage(
                  //                 image: AssetImage(
                  //                   "images/yandex_map.png",
                  //                 ),fit: BoxFit.fitWidth
                  //             )
                  //         ),
                  //       ),
                  //       Text("YANDEX MAPS".tr,style: kBoldThemeTextStyle.copyWith(fontSize: 10)),
                  //     ],
                  //   ))
                  // ],),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: Get.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: kMediumTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
