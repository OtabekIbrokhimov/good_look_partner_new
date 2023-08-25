import 'package:cutfx_salon/bloc/payout/payout_history_bloc.dart';
import 'package:cutfx_salon/model/payout/payout_history.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/ext/num_ext.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PayoutHistoryScreen extends StatelessWidget {
  const PayoutHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PayoutHistoryBloc(),
      child: Scaffold(
        body: Column(
          children: [
            ToolBarWidget(
              title: AppLocalizations.of(context)!.payoutHistory,
            ),
            BlocBuilder<PayoutHistoryBloc, PayoutHistoryState>(
              builder: (context, state) {
                if (state is PayoutHistoryDataFoundState) {
                  PayoutHistory payoutHistory = state.payoutHistory;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: payoutHistory.data?.length ?? 0,
                      padding: const EdgeInsets.only(top: 10),
                      itemBuilder: (context, index) {
                        PayoutHistoryData? payoutHistoryData =
                            payoutHistory.data?[index];
                        return Container(
                          color: ColorRes.smokeWhite,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    payoutHistoryData?.requestNumber ?? '',
                                    style: kMediumThemeTextStyle.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    (payoutHistoryData?.amount ?? 0).currency,
                                    style: kBoldThemeTextStyle.copyWith(
                                      fontSize: 18,
                                      color: ColorRes.mortar,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppRes.formatDate(
                                      AppRes.parseDate(
                                          payoutHistoryData?.createdAt ?? ''),
                                    ),
                                    style: kLightTextStyle.copyWith(
                                      color: ColorRes.mortar1,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppRes.getBackgroundColorByStatus(
                                              payoutHistoryData?.status ?? 0)
                                          .withOpacity(.2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 3,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppRes.getStringOfStatusByType(
                                          payoutHistoryData?.status ?? 0),
                                      style: kRegularWhiteTextStyle.copyWith(
                                        fontSize: 15,
                                        color:
                                            AppRes.getBackgroundColorByStatus(
                                                payoutHistoryData?.status ?? 0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                return const Expanded(
                  child: LoadingData(
                    color: ColorRes.white,
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
