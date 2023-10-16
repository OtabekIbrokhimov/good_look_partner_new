import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cutfx_salon/bloc/addmastertime/add_master_time_block.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../utils/color_res.dart';
import '../../utils/custom/custom_widget.dart';
import '../../utils/style_res.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddMasterTimeBlock(),
      child: BlocBuilder<AddMasterTimeBlock, AddMasterTimeState>(
        builder: (context, state) {
          AddMasterTimeBlock addtime = context.watch<AddMasterTimeBlock>();
          Get.arguments != null? addtime.pickTimes(Get.arguments):{};
          return Scaffold(
            backgroundColor: ColorRes.smokeWhite,
            body: Column(
              children: [
                const ToolBarWidget(
                  title: "Add Time",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: SafeArea(
                        top: false,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorRes.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 150,
                          height: 50,
                          child: TextButton(
                            style: const ButtonStyle(),
                            onPressed: () {
                              addtime.selectTime(context, true);
                            },
                            child: Text(
                              addtime.startTime,
                              style: kMediumTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: SafeArea(
                        top: false,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorRes.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 150,
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              addtime.selectTime(context, false);
                            },
                            child: Text(
                              addtime.endTime,
                              style: kMediumTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                CalendarDatePicker2(

                  config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.multi,
                    selectedRangeHighlightColor: ColorRes.fountainBlue,
selectedDayHighlightColor: ColorRes.themeColor,
                    disableModePicker: true,
                  ),
                  value: addtime.datas,
                  onValueChanged: (dates) {
                    addtime.takeTime(dates);
                  },
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: SafeArea(
                    top: false,
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: TextButton(
                        style: kButtonThemeStyle,
                        onPressed: () {
                          addtime.saveTime();
                        },
                        child: const Text(
                          "Save",
                          style: kRegularWhiteTextStyle,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
