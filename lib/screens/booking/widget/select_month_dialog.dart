import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';

class SelectMonthDialog extends StatefulWidget {
  final Function(int month, int year) onDoneClick;
  final int? month;
  final int? year;

  const SelectMonthDialog({
    Key? key,
    required this.onDoneClick,
    this.month,
    this.year,
  }) : super(key: key);

  @override
  State<SelectMonthDialog> createState() => _SelectMonthDialogState();
}

class _SelectMonthDialogState extends State<SelectMonthDialog> {
  int selectedIndex = 0;
  int year = DateTime.now().year;
  int currentYear = DateTime.now().year;

  @override
  void initState() {
    selectedIndex = widget.month != null ? widget.month! - 1 : 0;
    year = widget.year ?? DateTime.now().year;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> months = [
      AppLocalizations.of(context)!.jan,
      AppLocalizations.of(context)!.feb,
      AppLocalizations.of(context)!.mar,
      AppLocalizations.of(context)!.apr,
      AppLocalizations.of(context)!.may,
      AppLocalizations.of(context)!.jun,
      AppLocalizations.of(context)!.jul,
      AppLocalizations.of(context)!.aug,
      AppLocalizations.of(context)!.sep,
      AppLocalizations.of(context)!.oct,
      AppLocalizations.of(context)!.nov,
      AppLocalizations.of(context)!.dec,
    ];
    return Scaffold(
      backgroundColor: ColorRes.transparent,
      body: Center(
        child: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.selectMonth,
                        style: kBoldWhiteTextStyle.copyWith(
                          color: ColorRes.themeColor,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      CustomCircularInkWell(
                        onTap: () {
                          year--;
                          if (year >= currentYear - 1) {
                            setState(() {});
                          } else {
                            year++;
                          }
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: ColorRes.themeColor30,
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          year.toString(),
                          style: kRegularTextStyle.copyWith(
                            color: ColorRes.themeColor,
                          ),
                        ),
                      ),
                      CustomCircularInkWell(
                        onTap: () {
                          year++;
                          if (year <= currentYear + 1) {
                            setState(() {});
                          } else {
                            year--;
                          }
                        },
                        child: const RotatedBox(
                          quarterTurns: 2,
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: ColorRes.themeColor30,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      childAspectRatio: 1 / .6,
                    ),
                    shrinkWrap: true,
                    children: List.generate(
                      months.length,
                      (index) => CustomCircularInkWell(
                        onTap: () {
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? ColorRes.lavender
                                : Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 2,
                            vertical: 2,
                          ),
                          child: Center(
                            child: Text(
                              months[index],
                              style: kLightWhiteTextStyle.copyWith(
                                color: selectedIndex == index
                                    ? ColorRes.themeColor
                                    : ColorRes.empress,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomCircularInkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorRes.silver.withOpacity(.15),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.cancel,
                            style: kLightWhiteTextStyle.copyWith(
                              color: ColorRes.empress,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomCircularInkWell(
                        onTap: () {
                          widget.onDoneClick(selectedIndex + 1, year);
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorRes.themeColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.done,
                            style: kLightWhiteTextStyle.copyWith(
                              color: ColorRes.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
