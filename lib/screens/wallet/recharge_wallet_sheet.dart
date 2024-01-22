import 'package:cutfx_salon/utils/ext/num_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../bloc/recharge/recharge_wallet_bloc.dart';
import '../../utils/color_res.dart';
import '../../utils/custom/custom_widget.dart';
import '../../utils/style_res.dart';

class RechargeWalletSheet extends StatelessWidget {
  const RechargeWalletSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: BlocProvider(
          create: (context) => RechargeWalletBloc(),
          child: BlocBuilder<RechargeWalletBloc, RechargeWalletState>(
            builder: (context, state) {
              RechargeWalletBloc rechargeWalletBloc =
                  context.read<RechargeWalletBloc>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // AppLocalizations.of(Get.context!)!.
                            "rechargeWallet",
                            style: kSemiBoldThemeTextStyle.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            // AppLocalizations.of(Get.context!)!
                            //     .
                            "addMoneyToYourWalletToRecharge",
                            style: kLightWhiteTextStyle.copyWith(
                              color: ColorRes.empress,
                              fontSize: 14,
                            ),
                          ),
                        ],
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
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
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (rechargeWalletBloc.userData?.data?.wallet ?? 0)
                                .currency,
                            style: kBoldThemeTextStyle.copyWith(
                              fontSize: 35,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            // AppLocalizations.of(Get.context!)!
                            //     .
                            "pleaseRechargeYourWalletToContinueBooking",
                            style: kLightWhiteTextStyle.copyWith(
                              color: ColorRes.empress,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            // AppLocalizations.of(Get.context!)!.
                            "selectAmount",
                            style: kSemiBoldThemeTextStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomCircularInkWell(
                                  onTap: () {
                                    rechargeWalletBloc.selectAmountType(0);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      color: rechargeWalletBloc.type == 0
                                          ? ColorRes.themeColor
                                          : ColorRes.smokeWhite,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Center(
                                      child: Text(
                                        50.currency,
                                        style: kBoldThemeTextStyle.copyWith(
                                            fontSize: 16,
                                            color: rechargeWalletBloc.type == 0
                                                ? ColorRes.white
                                                : ColorRes.charcoal),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: CustomCircularInkWell(
                                  onTap: () {
                                    rechargeWalletBloc.selectAmountType(1);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: rechargeWalletBloc.type == 1
                                          ? ColorRes.themeColor
                                          : ColorRes.smokeWhite,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Center(
                                      child: Text(
                                        100.currency,
                                        style: kBoldThemeTextStyle.copyWith(
                                          fontSize: 16,
                                          color: rechargeWalletBloc.type == 1
                                              ? ColorRes.white
                                              : ColorRes.charcoal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: CustomCircularInkWell(
                                  onTap: () {
                                    rechargeWalletBloc.selectAmountType(2);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: rechargeWalletBloc.type == 2
                                          ? ColorRes.themeColor
                                          : ColorRes.smokeWhite,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Center(
                                      child: Text(
                                        150.currency,
                                        style: kBoldThemeTextStyle.copyWith(
                                          fontSize: 16,
                                          color: rechargeWalletBloc.type == 2
                                              ? ColorRes.white
                                              : ColorRes.charcoal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CustomCircularInkWell(
                            onTap: () {
                              rechargeWalletBloc.selectAmountType(3);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: rechargeWalletBloc.type == 3
                                    ? ColorRes.themeColor
                                    : ColorRes.smokeWhite,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                              ),
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 12),
                              child: Text(
                                // AppLocalizations.of(Get.context!)!
                                //      .
                                "other".toUpperCase(),
                                style: kBoldThemeTextStyle.copyWith(
                                  fontSize: 14,
                                  color: rechargeWalletBloc.type == 3
                                      ? ColorRes.white
                                      : ColorRes.charcoal,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: rechargeWalletBloc.type == 3,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: ColorRes.smokeWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              margin: const EdgeInsets.only(top: 10),
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: TextField(
                                decoration: const InputDecoration(
                                  hintText:
                                      //AppLocalizations.of(Get.context!)!
                                      //     .
                                      "enterAmountOfYourChoice",
                                  border: InputBorder.none,
                                ),
                                controller:
                                    rechargeWalletBloc.amountTextController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                style: kSemiBoldThemeTextStyle.copyWith(
                                  fontSize: 16,
                                  color: ColorRes.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 55,
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: TextButton(
                      style: kButtonThemeStyle,
                      onPressed: () {
                        // rechargeWalletBloc.onContinueTap();
                        Get.back();
                      },
                      child: const Text(
                        // AppLocalizations.of(Get.context!)!.
                        "proceed",
                        style: kRegularWhiteTextStyle,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
