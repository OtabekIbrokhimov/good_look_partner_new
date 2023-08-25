import 'package:cutfx_salon/bloc/earningreport/earning_report_bloc.dart';
import 'package:cutfx_salon/model/earninghistory/earning_history.dart';
import 'package:cutfx_salon/screens/booking/widget/select_month_dialog.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/ext/num_ext.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EarningScreen extends StatelessWidget {
  const EarningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EarningReportBloc(),
      child: Scaffold(
        body: BlocBuilder<EarningReportBloc, EarningReportState>(
          builder: (context, state) {
            EarningReportBloc earningReportBloc =
                context.read<EarningReportBloc>();
            EarningHistory? earningHistory;
            if (state is EarningReportDataFoundState) {
              earningHistory = state.earningHistory;
            }
            return Column(
              children: [
                Container(
                  color: ColorRes.smokeWhite,
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SafeArea(
                    bottom: false,
                    child: ToolBarWidget(
                      title: AppLocalizations.of(context)!.earningsReport,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorRes.smokeWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (earningReportBloc
                                            .salon?.data?.lifetimeEarnings ??
                                        0)
                                    .currency,
                                style: kBoldThemeTextStyle.copyWith(
                                  color: ColorRes.themeColor,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!.totalEarning,
                                style: kLightTextStyle.copyWith(
                                  color: ColorRes.empress,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorRes.smokeWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${earningReportBloc.salon?.data?.totalCompletedBookings}',
                                style: kBoldThemeTextStyle.copyWith(
                                  color: ColorRes.themeColor,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!.completedOrders,
                                style: kLightTextStyle.copyWith(
                                  color: ColorRes.empress,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorRes.smokeWhite,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(15),
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Text(
                              (earningHistory?.totalEarning() ?? 0).currency,
                              style: kSemiBoldTextStyle.copyWith(
                                fontSize: 18,
                                color: ColorRes.themeColor,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              decoration: const BoxDecoration(
                                color: ColorRes.themeColor10,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  const Image(
                                    image: AssetImage(
                                      AssetRes.icCalender,
                                    ),
                                    height: 18,
                                    width: 18,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomCircularInkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => SelectMonthDialog(
                                          onDoneClick:
                                              earningReportBloc.onMonthSelected,
                                          month: earningReportBloc.month,
                                          year: earningReportBloc.year,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      '${AppRes.convertMonthNumberToName(context, earningReportBloc.month)} ${earningReportBloc.year}',
                                      style: kLightTextStyle.copyWith(
                                        color: ColorRes.themeColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 1 / .55,
                        child: SfCartesianChart(
                          plotAreaBorderColor: ColorRes.transparent,
                          primaryXAxis: CategoryAxis(
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            majorGridLines: const MajorGridLines(width: 0),
                            axisLabelFormatter: (axisLabelRenderArgs) {
                              return ChartAxisLabel(
                                axisLabelRenderArgs.text,
                                kSemiBoldTextStyle.copyWith(
                                  color: ColorRes.black,
                                  fontSize: 12,
                                ),
                              );
                            },
                          ),
                          borderColor: Colors.transparent,
                          series: <LineSeries<SalesData, String>>[
                            LineSeries<SalesData, String>(
                              emptyPointSettings: EmptyPointSettings(
                                color: ColorRes.themeColor,
                                mode: EmptyPointMode.drop,
                                borderColor: ColorRes.white,
                                borderWidth: 2,
                              ),
                              dataSource: earningReportBloc.chartData,
                              // xAxisName: 'Sale',
                              // yAxisName: 'Purchase',
                              xValueMapper: (SalesData data, g) {
                                return data.year;
                              },
                              yValueMapper: (SalesData data, _) {
                                return data.sales.round();
                              },
                              color: ColorRes.themeColor,
                              markerSettings: const MarkerSettings(
                                shape: DataMarkerType.circle,
                                borderColor: ColorRes.themeColor,
                                color: ColorRes.themeColor,
                                height: 3.75,
                                width: 3.75,
                                isVisible: true,
                              ),

                              width: 1,
                            ),
                          ],
                          tooltipBehavior: TooltipBehavior(
                            enable: true,
                            activationMode: ActivationMode.singleTap,
                            color: ColorRes.smokeWhite,
                            borderWidth: 10,
                            elevation: 2,
                            duration: 2000,
                            tooltipPosition: TooltipPosition.auto,
                            shadowColor: ColorRes.darkGray,
                            header: '',
                            shouldAlwaysShow: true,
                            format: 'Day : point.x \nEarning : point.y  ',
                            textStyle: kThinWhiteTextStyle.copyWith(
                              color: ColorRes.themeColor,
                            ),
                          ),
                          zoomPanBehavior: ZoomPanBehavior(
                            enablePinching: true,
                            enablePanning: true,
                            zoomMode: ZoomMode.x,
                            // enableSelectionZooming: true,
                            // selectionRectColor: ColorRes.themeColor10,
                            // selectionRectBorderColor: ColorRes.themeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                earningHistory == null
                    ? const Expanded(
                        child: Center(
                          child: LoadingData(),
                        ),
                      )
                    : Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.all(0),
                                itemCount: earningHistory.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  Data? data = earningHistory?.data?[index];
                                  return Container(
                                    color: ColorRes.smokeWhite,
                                    margin: const EdgeInsets.only(top: 2),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data?.earningNumber ?? '',
                                              style: kSemiBoldThemeTextStyle
                                                  .copyWith(
                                                fontSize: 15,
                                                color: ColorRes.empress,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              AppRes.formatDate(
                                                  AppRes.parseDate(
                                                      data?.createdAt ?? '')),
                                              style: kLightTextStyle.copyWith(
                                                fontSize: 14,
                                                color: ColorRes.empress,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Text(
                                          (data?.amount ?? 0).currency,
                                          style:
                                              kSemiBoldThemeTextStyle.copyWith(
                                            fontSize: 18,
                                            color: ColorRes.charcoal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
