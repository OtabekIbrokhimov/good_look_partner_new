import 'package:cutfx_salon/bloc/wallet/wallet_bloc.dart';
import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/model/wallet/wallet_statement.dart';
import 'package:cutfx_salon/screens/wallet/recharge_wallet_sheet.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_bottom_sheet.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/ext/num_ext.dart';
import 'package:cutfx_salon/utils/shared_pref.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletBloc(),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: ColorRes.smokeWhite,
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 10),
              child: SafeArea(
                bottom: false,
                child: ToolBarWidget(
                  title: AppLocalizations.of(context)!.wallet,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(
                  colors: [
                    ColorRes.themeColor,
                    ColorRes.themeColor.withOpacity(0.9),
                    ColorRes.themeColor.withOpacity(0.8),
                    ColorRes.themeColor.withOpacity(0.6),
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: BlocBuilder<WalletBloc, WalletState>(
                builder: (context, state) {
                  Salon? salon = context.read<WalletBloc>().salon;
                  return Row(
                    children: [
                      Text(
                        (salon?.data?.wallet ?? 0).currency,
                        style: kLightWhiteTextStyle.copyWith(
                          fontSize: 28,
                          color: ColorRes.white,
                          letterSpacing: 1,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () async {
                          Get.bottomSheet(
                            const RechargeWalletSheet(),
                            isScrollControlled: true,
                            ignoreSafeArea: false,
                          );

                          SharePref sharePref = await SharePref().init();
                          if ((sharePref.getSalon()?.data?.wallet?.toInt() ??
                                  0) <
                              (sharePref
                                      .getSettings()
                                      ?.data
                                      ?.minAmountPayoutSalon
                                      ?.toInt() ??
                                  0)) {
                            // AppRes.showSnackBar(
                            //   AppLocalizations.of(Get.context!)!
                            //       .insufficientAmountToWithdraw,
                            //   false,
                            // );
                            return;
                          }
                          Get.bottomSheet(
                            ConfirmationBottomSheet(
                              title: AppLocalizations.of(Get.context!)!
                                  .withdrawTitle,
                              description: AppLocalizations.of(Get.context!)!
                                  .withdrawDescription,
                              buttonText:
                                  AppLocalizations.of(Get.context!)!.withdraw,
                              onButtonClick: () async {
                                AppRes.showCustomLoader();
                                await ApiService().submitSalonWithdrawRequest();
                                AppRes.hideCustomLoaderWithBack();
                              },
                            ),
                          ).then((value) {
                            context
                                .read<WalletBloc>()
                                .add(FetchSalonDataEvent());
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              ColorRes.white.withOpacity(.2)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Recharge wallet",
                            //""AppLocalizations.of(context)!.withdraw"",
                            style: kRegularWhiteTextStyle.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, bottom: 15),
              child: Text(
                AppLocalizations.of(context)!.statement,
                style: kRegularTextStyle.copyWith(
                  color: ColorRes.titleText,
                ),
              ),
            ),
            BlocBuilder<WalletBloc, WalletState>(
              builder: (context, state) {
                WalletBloc walletBloc = context.read<WalletBloc>();
                return state is! WalletStatementDataFoundState
                    ? const Expanded(child: Center(child: LoadingData()))
                    : Expanded(
                        child: walletBloc.walletStatements.isEmpty
                            ? const Center(child: DataNotFound())
                            : SafeArea(
                                top: false,
                                child: ListView.builder(
                                  controller: walletBloc.scrollController,
                                  padding: const EdgeInsets.all(0),
                                  itemCount: walletBloc.walletStatements.length,
                                  itemBuilder: (context, index) {
                                    WalletStatementData? walletStatement =
                                        walletBloc.walletStatements[index];
                                    return ItemWalletStatement(
                                      walletStatementData: walletStatement,
                                    );
                                  },
                                ),
                              ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ItemWalletStatement extends StatelessWidget {
  final WalletStatementData walletStatementData;

  const ItemWalletStatement({Key? key, required this.walletStatementData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      color: walletStatementData.crOrDr == 0
          ? ColorRes.bitterSweet10
          : ColorRes.islamicGreen10,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: walletStatementData.crOrDr == 0
                  ? ColorRes.bitterSweet
                  : ColorRes.islamicGreen,
              borderRadius: BorderRadius.circular(100),
            ),
            height: 30,
            width: 30,
            child: Center(
              child: Image(
                height: 30,
                width: walletStatementData.crOrDr == 0 ? 12 : 20,
                image: AssetImage(
                  walletStatementData.crOrDr == 0
                      ? AssetRes.icMinus
                      : AssetRes.icPlus_,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 220,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(
                          '${walletStatementData.transactionId} - ',
                          style: kRegularTextStyle.copyWith(
                            fontSize: 14,
                            color: ColorRes.empress,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text(
                          AppRes.getStringOfWalletByType(
                              walletStatementData.type ?? 0),
                          style: kRegularTextStyle.copyWith(
                            color: AppRes.getColorOfWalletByType(
                                walletStatementData.crOrDr ?? 0),
                            fontSize: 15,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  AppRes.formatDate(
                      AppRes.parseDate(walletStatementData.createdAt ?? '')),
                  style: kThinWhiteTextStyle.copyWith(
                    fontSize: 14,
                    color: ColorRes.empress,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${AppRes.getPlusOrMinusOfWalletByType(walletStatementData.crOrDr ?? 0)}${(walletStatementData.amount ?? 0).currency}',
            style: kRegularTextStyle.copyWith(
              fontSize: 16,
              color: ColorRes.empress,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
