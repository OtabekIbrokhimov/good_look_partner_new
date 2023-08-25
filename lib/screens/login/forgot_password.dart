import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';

class ForgotPasswordBottomSheet extends StatelessWidget {
  const ForgotPasswordBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return Container(
      height: 350,
      decoration: const BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.forgotYourPassword,
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
            const SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!
                  .enterYourEmailAddressOnWhichWeWillSendYouTheLinkToResetThePassword,
              style: kRegularTextStyle,
            ),
            const Spacer(),
            TextWithTextFieldSmokeWhiteWidget(
              title: AppLocalizations.of(context)!.emailAddress,
              controller: emailController,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: TextButton(
                style: kButtonThemeStyle,
                onPressed: () async {
                  if (emailController.text.isEmpty) {
                    AppRes.showSnackBar(
                        AppLocalizations.of(context)!.pleaseEnterEmailAddress,
                        false);
                    return;
                  }

                  try {
                    AppRes.showCustomLoader();
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(email: emailController.text)
                        .then((value) {
                      Get.back();
                      Get.back();
                      AppRes.showSnackBar(
                          AppLocalizations.of(context)!
                              .passwordResetLinkSentSuccessfully,
                          true);
                    });
                  } on FirebaseAuthException catch (e) {
                    AppRes.showSnackBar("${e.message}", false);
                  }
                },
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
