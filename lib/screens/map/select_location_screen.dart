import 'package:cutfx_salon/screens/main/main_screen.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({Key? key}) : super(key: key);

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  GoogleMapController? _controller;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.2995, 69.2401),
    zoom: 11.0,
  );
  Location currentLocation = Location();
  final Set<Marker> _markers = {};
  LatLng? latLng = const LatLng(41.2995, 69.2401);
  dynamic location;
  bool isLoading = true;

  @override
  void initState() {
    if (isLoading) {
      getLocation();
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
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              indoorViewEnabled: true,
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
              onTap: (argument) {
                latLng = argument;
                _controller?.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: latLng!, zoom: 15, bearing: 90, tilt: 30),
                  ),
                );

                if (mounted) {
                  setState(() {
                    _markers.add(
                      Marker(
                        markerId: const MarkerId('Home'),
                        position: LatLng(
                            latLng?.latitude ?? 0.0, latLng?.longitude ?? 0.0),
                      ),
                    );
                  });
                }
              },
              markers: _markers,
              zoomControlsEnabled: false,
            ),
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
                      if (latLng?.latitude != null ||
                          latLng?.longitude != null) {
                        Get.back(result: latLng);
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
            getLocation();
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

  void getLocation() async {
    setState(() {
      isLoading = false;
    });
    var locationData = await currentLocation.getLocation();
    setState(() {
      isLoading = true;
    });
    latLng = LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0);
    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng!, zoom: 15, bearing: 90, tilt: 30),
      ),
    );

    if (mounted) {
      setState(() {
        _markers.add(Marker(
            markerId: const MarkerId('Home'),
            position: LatLng(
                locationData.latitude ?? 0.0, locationData.longitude ?? 0.0)));
      });
    }
    // currentLocation.onLocationChanged.listen((event) {
    //
    // });
  }
}
