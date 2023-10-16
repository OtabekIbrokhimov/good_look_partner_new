import 'package:cutfx_salon/screens/add_master/calendar_screen.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../bloc/directmastertime/direct_master_time_block.dart';
import '../../utils/asset_res.dart';
import '../../utils/custom/custom_bottom_sheet.dart';
import '../main/main_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AddTimeScreen extends StatefulWidget {
  const AddTimeScreen({super.key});

  @override
  State<AddTimeScreen> createState() => _AddTimeScreenState();
}

class _AddTimeScreenState extends State<AddTimeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DirectMasterBlock(),
        child: BlocBuilder<DirectMasterBlock, DirectMasterTimeState>(
            builder: (context, state) {
            DirectMasterBlock directMasterBlock = context.read<DirectMasterBlock>();
          return Scaffold(
              backgroundColor: ColorRes.smokeWhite,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  directMasterBlock.getToCalendar();
                },
                backgroundColor: ColorRes.themeColor,
                child: const Icon(
                  Icons.add,
                  size: 40,
                ),
              ),
              body: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                                    color: const Color(0xff62B654),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 150,
                                  height: 50,
                                  child: TextButton(
                                    style: const ButtonStyle(),
                                    onPressed: () {},
                                    child: const Text(
                                      'Free time',
                                      style: kRegularWhiteTextStyle,
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
                                    color: const Color(0xffFF6C6C),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 150,
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Work time',
                                      style: kRegularWhiteTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height - 200,
                          child: ListView.builder(
                              shrinkWrap: true,
                          itemCount: directMasterBlock.mainList.date?.length??0,
                          itemBuilder: (context, index) {
                            return TimeInfoWidget(
                              startDate:
                                   directMasterBlock.mainList.date?[index].date?[0].start ??
                                      "",
                              day: directMasterBlock.mainList.date?[index].date?[0].date ??
                                  "",
                              endDate:
                                   directMasterBlock.mainList.date?[index].date?[0].end ??
                                      "",
                              delete: () {
                                directMasterBlock.deleteDay(index);
                              },
                              edit: () {
                                Get.off(() => const CalendarScreen(),
                                    arguments:
                                        directMasterBlock.mainList.date?[index]);
                                directMasterBlock.deleteDay(index,isEdit: true);
                              },
                            );
                          }),
                        ),
                      ]));
            }));
  }
}

class TimeInfoWidget extends StatelessWidget {
  final String startDate;
  final String day;
  final String endDate;
  final Function delete;
  final Function edit;

  const TimeInfoWidget({
    super.key,
    required this.startDate,
    required this.day,
    required this.endDate,
    required this.delete,
    required this.edit,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: Container(
          margin: const EdgeInsets.all(14),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: ColorRes.grey),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                '$startDate - $endDate',
                style: kMediumThemeTextStyle,
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: BgRoundImageWidget(
                      image: AssetRes.icEdit,
                      onTap: () {
                        edit();
                      },
                      height: 30,
                      width: 30,
                      imagePadding: 5,
                      bgColor: ColorRes.charcoal50,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: BgRoundImageWidget(
                      image: AssetRes.icRemove,
                      onTap: () {
                        Get.bottomSheet(
                          ConfirmationBottomSheet(
                            title: "Delete",
                            description: "Do you wanna delete this date",
                            buttonText: AppLocalizations.of(context)!.continue_,
                            onButtonClick: () {
                              delete();
                              }));
                            },


                      height: 30,
                      width: 30,
                      imagePadding: 5,
                      bgColor: ColorRes.charcoal50,
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
