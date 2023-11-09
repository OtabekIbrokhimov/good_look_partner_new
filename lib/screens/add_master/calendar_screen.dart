import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cutfx_salon/bloc/addmastertime/add_master_time_block.dart';
import 'package:cutfx_salon/screens/add_master/add_master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
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
          return Scaffold(
            backgroundColor: ColorRes.smokeWhite,
            body: Column(
              children: [
                const ToolBarWidget(
                  title: '',
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
                              timePicking2(context,addtime,true);

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
                              timePicking2(context,addtime,false);
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
                  value: addtime.datas + addtime.dataForCheck,
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

  void timePicking2(BuildContext context, AddMasterTimeBlock ok, bool isStart) {
    Get.bottomSheet(Container(
        padding: const EdgeInsets.all(15),
        height: Get.height / 2,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.close,color: ColorRes.black,size: 35,)
                ),

              ],
            ),
            TimePickerSpinner(
              minutesInterval: 15,
              is24HourMode: true,
              normalTextStyle:
                  const TextStyle(fontSize: 24, color: Colors.grey),
              highlightedTextStyle:
                  const TextStyle(fontSize: 24, color: ColorRes.themeColor),
              spacing: 50,
              itemHeight: 80,
              isForce2Digits: true,
              onTimeChange: (time) {
                ok.selectTime(time, isStart);
              },
            ),

          ],
        )),
    enableDrag: false
    );
  }
}
