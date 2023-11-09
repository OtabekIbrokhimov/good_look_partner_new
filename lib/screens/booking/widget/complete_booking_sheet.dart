import 'package:cutfx_salon/model/request/request_details.dart';
import 'package:cutfx_salon/model/rest/rest_response.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../utils/asset_res.dart';
import '../../qrScan/qr_scan_screen.dart';

class CompleteBookingSheet extends StatefulWidget {
   CompleteBookingSheet({super.key, required this.requestDetails});
  final RequestDetails requestDetails;
  TextEditingController textEditingController = TextEditingController();
  @override
  State<CompleteBookingSheet> createState() => _CompleteBookingSheetState();
}

class _CompleteBookingSheetState extends State<CompleteBookingSheet> {

 void takeCode(String code){
   Get.log(code);
   int second = 0;
   setState(() {
     widget.textEditingController.text = code;
   });
   Get.back();
   return;
 }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      bottom: false,
      child: Container(
        height: 350,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.completeBooking,
                    style: kBoldThemeTextStyle,
                  ),
                  const Spacer(),
                  CloseButtonWidget(
                    onTap: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
            Text(
              AppLocalizations.of(context)!
                  .pleaseEnterTheCompletionOtpBelowntoCompleteTheBookingnaskCustomer,
              style: kLightTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: Get.width,
              height: 60,
              child: Row(
                children: [
                  SizedBox(
                    height: 60,
                    width: Get.width-70,
                    child: TextWithTextFieldSmokeWhiteWidget(
                      title: '',
                      controller: widget.textEditingController,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      Get.to(()=> QrScanScreen(needResult: true,function: takeCode));

                    },
                    child: const Image(
                      image: AssetImage(
                        AssetRes.icScan,
                      ),
                      color: Colors.black,
                      height: 30,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: TextButton(
                  onPressed: () async {
                    if (widget.textEditingController.text.isEmpty) {
                      AppRes.showSnackBar('Please enter OTP.', false);
                      return;
                    }
                    AppRes.showCustomLoader();
                    RestResponse restResponse = await ApiService()
                        .completeBooking(widget.requestDetails.data?.bookingId ?? '',
                            widget.textEditingController.text);
                    if (!restResponse.status!) {
                      AppRes.hideCustomLoader();

                      AppRes.showSnackBar(restResponse.message ?? '', false);
                    } else {
                      AppRes.hideCustomLoaderWithBack();
                    }
                  },
                  style: kButtonThemeStyle,
                  child: Text(
                    AppLocalizations.of(context)!.submit,
                    style: kBlackButtonTextStyle.copyWith(
                      color: ColorRes.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
