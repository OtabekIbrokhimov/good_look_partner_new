import 'package:cutfx_salon/model/setting/setting.dart';
import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/screens/welcome/welcome_screen.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_bottom_sheet.dart';
import 'package:cutfx_salon/utils/custom/custom_dialog.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/shared_pref.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class BanSalonInfoScreen extends StatefulWidget {
  const BanSalonInfoScreen({Key? key}) : super(key: key);

  @override
  State<BanSalonInfoScreen> createState() => _BanSalonInfoScreenState();
}

class _BanSalonInfoScreenState extends State<BanSalonInfoScreen> {
  SalonData? salonData;
  SettingData? settingData;

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: ColorRes.bitterSweet1,
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 25,
              top: 50,
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Image(
                    image: AssetImage(AssetRes.icTag),
                    height: 70,
                    color: ColorRes.bitterSweet,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.yourSalonHasBeenBanned,
                        style: const TextStyle(
                          color: ColorRes.bitterSweet,
                          fontFamily: AssetRes.fnGilroyBlack,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              AppLocalizations.of(context)!
                  .yourSalonHasBeenBannedBySuperAdminPleaseContact,
              style: kLightTextStyle.copyWith(
                color: ColorRes.charcoal50,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              settingData?.supportEmail ?? '',
              style: kRegularTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
          ),
          const Spacer(),
          SafeArea(
            child: CustomCircularInkWell(
              onTap: () {
                Get.bottomSheet(
                  ConfirmationBottomSheet(
                    title: AppLocalizations.of(context)!.logOut,
                    description: AppLocalizations.of(context)!.logoutDec,
                    buttonText: AppLocalizations.of(context)!.continue_,
                    onButtonClick: () async {
                      showDialog(
                        context: Get.context!,
                        builder: (context) {
                          return const CustomLoader();
                        },
                        barrierDismissible: false,
                      );
                      await FirebaseAuth.instance.signOut();
                      SharePref sharePref = await SharePref().init();
                      await sharePref.clear();
                      Get.off(() => const WelComeScreen());
                    },
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                color: ColorRes.smokeWhite,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.logOut,
                    style: kLightTextStyle.copyWith(
                      color: ColorRes.mortar1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void initData() async {
    SharePref sharePref = await SharePref().init();
    salonData = sharePref.getSalon()?.data;

    settingData = sharePref.getSettings()?.data;
    setState(() {});
  }
}
