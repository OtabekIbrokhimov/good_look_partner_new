import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 15,
      ),
      child: SafeArea(
        child: Column(
          verticalDirection: VerticalDirection.down,
          children: [
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.changePassword,
                  style: kBoldThemeTextStyle,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(
                      color: ColorRes.lavender,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: const Icon(
                      Icons.close_rounded,
                      color: ColorRes.themeColor,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      height: 20,
                    ),
                    TextWithTextFieldSmokeWhiteWidget(
                      title: AppLocalizations.of(context)!.oldPassword,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: 10,
                    ),
                    TextWithTextFieldSmokeWhiteWidget(
                      title: AppLocalizations.of(context)!.newPassword,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: 10,
                    ),
                    TextWithTextFieldSmokeWhiteWidget(
                      title: AppLocalizations.of(context)!.confirmPassword,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: TextButton(
                style: kButtonThemeStyle,
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context)!.continue_,
                  style: kRegularWhiteTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
