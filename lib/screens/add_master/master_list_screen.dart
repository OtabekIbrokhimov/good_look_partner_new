import 'package:cutfx_salon/bloc/masterlistblock/master_list_bloc.dart';
import 'package:cutfx_salon/screens/add_master/add_master_screen.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../utils/asset_res.dart';
import '../../utils/const_res.dart';
import '../../utils/custom/custom_bottom_sheet.dart';
import '../../utils/custom/custom_widget.dart';
import '../../utils/shared_pref.dart';
import '../main/main_screen.dart';

class MasterListScreen extends StatelessWidget {
  const MasterListScreen({super.key, this.needManage = true});

  final bool needManage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MasterListBloc(),
        child: BlocBuilder<MasterListBloc, MasterListState>(
            builder: (context, state) {
          MasterListBloc masters = context.read<MasterListBloc>();
          return Scaffold(
            floatingActionButton: needManage
                ? FloatingActionButton(
                    onPressed: () async {
                      SharePref sharePref = await SharePref().init();
                      sharePref.saveString(AppRes.calendarDates, '');
                      String? l = await Get.to(
                        () => AddMasterScreen(),
                      );
                      if (l != null) {
                        masters.fetchMasters();
                      }
                    },
                    backgroundColor: ColorRes.themeColor,
                    child: const Icon(
                      Icons.add,
                      size: 40,
                    ),
                  )
                : const SizedBox(),
            backgroundColor: ColorRes.white,
            body: Column(
              children: [
                Visibility(
                  visible: needManage,
                  child: ToolBarWidget(
                    title: AppLocalizations.of(context)!.masterList,
                  ),
                ),
                Flexible(
                    child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: masters.masterList?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return MasterItem2(
                        needManage: needManage,
                        photo: masters.masterList?.data?[index].photo ?? "",
                        fullName:
                            masters.masterList?.data?[index].fullname ?? "",
                        delete: () {
                          masters.deleteMaster(
                              masters.masterList?.data?[index].id.toString() ??
                                  "");
                        },
                        edit: () async {
                          SharePref sharePref = await SharePref().init();
                          sharePref.saveString(AppRes.calendarDates, '');
                          String? l = await Get.to(
                              () => AddMasterScreen(
                                    master: masters.masterList?.data?[index],
                                  ),
                              arguments: masters.masterList?.data?[index]);
                          if (l != null) {
                            masters.fetchMasters();
                          } else {
                            masters.fetchMasters();
                          }
                        });
                  },
                )),
              ],
            ),
          );
        }));
  }
}

class MasterItem2 extends StatelessWidget {
  final String photo;
  final String fullName;
  final Function delete;
  final Function edit;
  final String service;
  final bool needManage;

  const MasterItem2({
    super.key,
    required this.photo,
    required this.fullName,
    required this.delete,
    required this.edit,
    this.service = '',
    this.needManage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      color: ColorRes.smokeWhite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage('${ConstRes.itemBaseUrl}$photo'),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              fullName,
                              style: kRegularTextStyle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          // Text(
                          //   'ncsjikcnsdj',
                          //   style: kLightWhiteTextStyle.copyWith(
                          //     color: ColorRes.themeColor,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Visibility(
                      visible: needManage,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25, right: 5),
                        child: PopupMenuButton(
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                child: Text(
                                  AppLocalizations.of(context)!.edit,
                                  style: kMediumTextStyle.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                                onTap: () async {
                                  edit();
                                },
                              ),
                              PopupMenuItem(
                                child: Text(
                                  AppLocalizations.of(context)!.delete,
                                  style: kMediumTextStyle.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                                onTap: () {
                                  Get.bottomSheet(ConfirmationBottomSheet(
                                      title:
                                          AppLocalizations.of(context)!.delete,
                                      description: AppLocalizations.of(context)!
                                          .doYouWannaMaster,
                                      buttonText: AppLocalizations.of(context)!
                                          .continue_,
                                      onButtonClick: () {
                                        delete();
                                      }));
                                },
                              ),
                            ];
                          },
                          child: const BgRoundImageWidget(
                            image: AssetRes.icMore,
                            bgColor: ColorRes.smokeWhite1,
                            imagePadding: 5,
                            height: 35,
                            width: 35,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  service,
                  style: kLightWhiteTextStyle.copyWith(
                    color: ColorRes.empress,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MasterItem extends StatelessWidget {
  final String photo;
  final String fullName;
  final Function delete;
  final Function edit;

  const MasterItem({
    super.key,
    required this.photo,
    required this.fullName,
    required this.delete,
    required this.edit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorRes.black.withOpacity(0.1),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              child: Image(
                  image: NetworkImage('${ConstRes.itemBaseUrl}$photo'),
                  fit: BoxFit.cover,
                  height: 45,
                  width: 45,
                  errorBuilder: (context, v, b) {
                    return errorBuilderForImage(context, v, b,
                        name: fullName ?? "");
                  },
                  loadingBuilder: (context, child, l) {
                    return loadingImage(context, child, l);
                  }),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(fullName, style: kMediumThemeTextStyle),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: BgRoundImageWidget(
                            image: AssetRes.icRemove,
                            onTap: () {
                              Get.bottomSheet(ConfirmationBottomSheet(
                                  title: AppLocalizations.of(context)!.delete,
                                  description: AppLocalizations.of(context)!
                                      .doYouWannaMaster,
                                  buttonText:
                                      AppLocalizations.of(context)!.continue_,
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
