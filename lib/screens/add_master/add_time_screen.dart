import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../bloc/directmastertime/direct_master_time_block.dart';
import '../../utils/asset_res.dart';
import '../../utils/custom/custom_bottom_sheet.dart';
import '../main/main_screen.dart';
class AddTimeScreen extends StatefulWidget {
  const AddTimeScreen({super.key, this.title = "Add time"});

  final String title;

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
                    ToolBarWidget(
                      title: widget.title,
                    ),
                    directMasterBlock.mainList.date!.isEmpty?const SizedBox(): directMasterBlock.mainList.date!.first!.date!.isNotEmpty? SizedBox(
                      height: Get.height - 200,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: directMasterBlock.mainList.date?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TimeInfoWidget(
                              startDate: directMasterBlock
                                      .mainList.date?[index].date?[0].start ?? "",
                              day: directMasterBlock
                                      .mainList.date?[index].date?[0].date ??
                                  "",
                              endDate: directMasterBlock
                                      .mainList.date?[index].date?[0].end ??
                                  "",
                              delete: () {
                                directMasterBlock.deleteDay(index);
                              },
                              edit: () {
                                directMasterBlock.edit(index);
                              },
                            );
                          }),
                        ):SizedBox(),
                      ]));
            }));
  }
}

class TimeInfoWidget extends StatelessWidget {
  final String startDate;
  final String day;
  final String endDate;
  final Function delete;
  final Function() edit;

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
                '${formatTime(startDate.split(":").first)}:${formatTime(startDate.split(":")[1])} - ${formatTime(endDate.split(":").first)}:${formatTime(endDate.split(":")[1])}',
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
                        Get.bottomSheet(ConfirmationBottomSheet(
                            title: AppLocalizations.of(context)!.delete,
                            description:
                                AppLocalizations.of(context)!.doYouWannaDate,
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

  String formatTime(String value) {
    if (value.length > 1) {
      return value;
    } else {
      return "0$value";
    }
  }
}
