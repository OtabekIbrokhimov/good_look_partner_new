import 'package:cutfx_salon/screens/main/main_screen.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({Key? key}) : super(key: key);

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  // GoogleMapController? _controller;
  //
  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(41.2995, 69.2401),
  //   zoom: 11.0,
  // );
  // Location currentLocation = Location();
  // final Set<Marker> _markers = {};
  //LatLng? latLng = const LatLng(41.2995, 69.2401);
  dynamic location;
  bool isLoading = true;

  BitmapDescriptor? bitmapDescriptor;
  late String mapStyle;
  final List<MapObject> mapObjects = [];
  Position? position;

  @override
  void initState() {
    if (isLoading) {
      findUser();
      // getLocation();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
              bottom: false,
              child: YandexMap(
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
                      findUser();
                        yandexMapController.moveCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(
                                target: Point(
                                    latitude: position?.latitude ?? 41.344517,
                                    longitude: position?.longitude ?? 69.2714301),
                                zoom: 20.0)));
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

                  // final cameraPosition =
                  // await yandexMapController.getCameraPosition().then(
                  //       (value) async {
                  //     await yandexMapController
                  //         .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  //         target: Point(
                  //           latitude:
                  //           longitude: double.parse(
                  //               widget.salon?.data?.salonLong ?? '0'),
                  //         ),
                  //         zoom: 12.0)));
                  //   },
                  // );
                  //  determinePosition();
                },
              )
              // GoogleMap(
              //   mapType: MapType.hybrid,
              //   initialCameraPosition: _kGooglePlex,
              //   indoorViewEnabled: true,
              //   myLocationButtonEnabled: false,
              //   myLocationEnabled: false,
              //   onMapCreated: (GoogleMapController controller) {
              //     _controller = controller;
              //   },
              //   onTap: (argument) {
              //     latLng = argument;
              //     _controller?.animateCamera(
              //       CameraUpdate.newCameraPosition(
              //         CameraPosition(
              //             target: latLng!, zoom: 15, bearing: 90, tilt: 30),
              //       ),
              //     );
              //
              //     if (mounted) {
              //       setState(() {
              //         _markers.add(
              //           Marker(
              //             markerId: const MarkerId('Home'),
              //             position: LatLng(
              //                 latLng?.latitude ?? 0.0, latLng?.longitude ?? 0.0),
              //           ),
              //         );
              //       });
              //     }
              //   },
              //   markers: _markers,
              //   zoomControlsEnabled: false,
              // ),
              ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SafeArea(
                child: SizedBox(
                  height: 45,
                  width: 150,
                  child: TextButton(
                    onPressed: () {
                      if (position?.latitude != null ||
                          position?.longitude != null) {
                        Get.back(result: position);
                        } else {
                          AppRes.showSnackBar(
                              AppLocalizations.of(context)!.locationNotFount,
                              false);
                        }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ColorRes.themeColor),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.done,
                      style: kLightWhiteTextStyle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12),
              child: BgRoundImageWidget(
                image: AssetRes.icBack,
                imagePadding: 6,
                bgColor: ColorRes.themeColor,
                imageColor: ColorRes.white,
                onTap: () => Get.back(),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorRes.themeColor,
        onPressed: () {
          if (isLoading) {
         findUser();
          }
        },
        child: !isLoading
            ? const Padding(
                padding: EdgeInsets.all(15),
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Icon(
                Icons.location_searching,
                color: ColorRes.white,
              ),
      ),
    );
  }

  void findUser() async {
    Location location = Location();
    bool serviceEnabled = false;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }
      position = await Geolocator.getCurrentPosition();
      Get.log("${position?.latitude ?? 0} ${position?.longitude ?? 0} + maaa");
      setState(() {
      });

    //
    // void getLocation() async {
    //   setState(() {
    //     isLoading = false;
    //   });
    //   var locationData = await currentLocation.getLocation();
    //   setState(() {
    //     isLoading = true;
    //   });
    //   latLng = LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0);
    //   _controller?.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(target: latLng!, zoom: 15, bearing: 90, tilt: 30),
    //     ),
    //   );
    //
    //   if (mounted) {
    //     setState(() {
    //       _markers.add(Marker(
    //           markerId: const MarkerId('Home'),
    //           position: LatLng(
    //               locationData.latitude ?? 0.0, locationData.longitude ?? 0.0)));
    //     });
    //   }
    //   // currentLocation.onLocationChanged.listen((event) {
    //   //
    //   // });
    // }
  }
}
