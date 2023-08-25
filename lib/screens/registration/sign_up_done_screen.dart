import 'package:cutfx_salon/model/setting/setting.dart';
import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/shared_pref.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpDoneScreen extends StatefulWidget {
  const SignUpDoneScreen({Key? key}) : super(key: key);

  @override
  State<SignUpDoneScreen> createState() => _SignUpDoneScreenState();
}

class _SignUpDoneScreenState extends State<SignUpDoneScreen> {
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
            color: ColorRes.lavender,
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
                    image: AssetImage(AssetRes.icDone),
                    height: 70,
                    color: ColorRes.themeColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.salon.toUpperCase(),
                        style: const TextStyle(
                          color: ColorRes.themeColor,
                          fontFamily: AssetRes.fnGilroyBlack,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(
                          AppLocalizations.of(context)!.registration,
                          style: const TextStyle(
                            color: ColorRes.themeColor,
                            fontFamily: AssetRes.fnProductSansLight,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.submissionSuccessful,
                    style: kSemiBoldTextStyle.copyWith(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${AppLocalizations.of(context)!.requestID} : ${salonData?.salonNumber ?? ''}',
                    style: kLightTextStyle.copyWith(
                      color: ColorRes.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              AppLocalizations.of(context)!.salonOwnerNotice,
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
