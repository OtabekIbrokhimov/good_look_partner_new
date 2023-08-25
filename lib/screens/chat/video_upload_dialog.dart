import 'dart:ui';

import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class VideoUploadDialog extends StatelessWidget {
  final VoidCallback selectAnother;

  const VideoUploadDialog({Key? key, required this.selectAnother})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 65),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: AspectRatio(
          aspectRatio: 1,
          child: Column(
            children: [
              const Spacer(flex: 2),
              RichText(
                text: TextSpan(
                  style: kSemiBoldThemeTextStyle,
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.tooLarge,
                      style: const TextStyle(color: ColorRes.mortar),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.video,
                      style: const TextStyle(color: ColorRes.mortar),
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppLocalizations.of(context)!
                      .thisVideoIsGreaterThan15MbnpleaseSelectAnother,
                  style: kSemiBoldThemeTextStyle.copyWith(
                    color: ColorRes.charcoal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              InkWell(
                highlightColor: ColorRes.transparent,
                splashColor: ColorRes.transparent,
                onTap: selectAnother,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorRes.themeColor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.selectAnother,
                    style: kSemiBoldThemeTextStyle,
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                highlightColor: ColorRes.transparent,
                splashColor: ColorRes.transparent,
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: kSemiBoldThemeTextStyle.copyWith(
                      color: ColorRes.charcoal,
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
