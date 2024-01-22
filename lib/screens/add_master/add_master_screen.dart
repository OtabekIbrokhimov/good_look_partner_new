import 'dart:io';

import 'package:cutfx_salon/bloc/edit/edit_profile_bloc.dart';
import 'package:cutfx_salon/model/masters/master_responce.dart';
import 'package:cutfx_salon/screens/add_master/choose_service_screen.dart';
import 'package:cutfx_salon/screens/main/main_screen.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class AddMasterScreen extends StatefulWidget {
  AddMasterScreen({super.key, this.master});

  Master? master;

  @override
  State<AddMasterScreen> createState() => _AddMasterScreenState();
}

class _AddMasterScreenState extends State<AddMasterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EditProfileBloc(),
        child: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            EditProfileBloc editProfileBloc = context.read<EditProfileBloc>();
            //editProfileBloc.takeAllInformation(widget.master);
            return Scaffold(
              body: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                        height: Get.height - 50,
                        child: Column(
                          children: [
                            Container(
                              color: ColorRes.smokeWhite,
                              width: double.infinity,
                              padding: const EdgeInsets.only(bottom: 15),
                              child: SafeArea(
                                bottom: false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomCircularInkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Image(
                                          image: AssetImage(AssetRes.icBack),
                                          height: 30,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .createMaster,
                                        style: kBoldThemeTextStyle,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: ColorRes.themeColor,
                                      ),
                                      padding: const EdgeInsets.all(1),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        child: Stack(
                                          children: [
                                            editProfileBloc.imageFile != null
                                                ? Image(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    image: FileImage(
                                                      editProfileBloc
                                                              .imageFile ??
                                                          File('path'),
                                                    ),
                                                    fit: BoxFit.cover,
                                                    loadingBuilder:
                                                        loadingImage,
                                                    errorBuilder:
                                                        errorBuilderForImage,
                                                  )
                                                : Image(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    image: NetworkImage(
                                                        '${ConstRes.itemBaseUrl}${editProfileBloc.imageUrl}'),
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (context, v, b) {
                                                      return errorBuilderForImage(
                                                          context, v, b,
                                                          name: editProfileBloc
                                                                  .fullNameTextController
                                                                  .text ??
                                                              "",
                                                          isSalonImage: true);
                                                    },
                                                    loadingBuilder:
                                                        (context, child, l) {
                                                      return loadingImage(
                                                          context, child, l);
                                                    }),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: BgRoundImageWidget(
                                                  image: AssetRes.icEdit,
                                                  onTap: () {
                                                    editProfileBloc.add(
                                                        ImageSelectClickEvent());
                                                  },
                                                  height: 30,
                                                  width: 30,
                                                  imagePadding: 5,
                                                  bgColor: ColorRes.charcoal50,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextWithTextFieldSmokeWhiteWidget(
                                      title: AppLocalizations.of(context)!
                                          .fullName,
                                      controller: editProfileBloc
                                          .fullNameTextController,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            EditWidget(
                              title: AppLocalizations.of(context)!.editService,
                              onTapEdit: () async {
                                List<int> items = await Get.to(
                                    () => const ChooseServiceScreen(),
                                    arguments: editProfileBloc.ids);
                                Get.log(items.toString());
                                editProfileBloc.takeIds(items);
                              },
                            ),
                            EditWidget(
                              title:
                                  AppLocalizations.of(context)!.manageWorkTime,
                              onTapEdit: () {
                                editProfileBloc.onTapEdit(
                                    AppLocalizations.of(context)!
                                        .manageWorkTime,
                                    1);
                              },
                            ),
                            EditWidget(
                              title:
                                  AppLocalizations.of(context)!.manageFreeTime,
                              onTapEdit: () {
                                editProfileBloc.onTapEdit(
                                    AppLocalizations.of(context)!
                                        .manageFreeTime,
                                    2);
                              },
                            ),
                            EditWidget(
                              title:
                                  AppLocalizations.of(context)!.manageVocation,
                              onTapEdit: () {
                                editProfileBloc.onTapEdit(
                                    AppLocalizations.of(context)!
                                        .manageVocation,
                                    3);
                              },
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: SafeArea(
                                top: false,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 55,
                                  child: TextButton(
                                    style: kButtonThemeStyle,
                                    onPressed: () {
                                      editProfileBloc.createMaster(
                                          editProfileBloc.needCreate);
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.submit,
                                      style: kRegularWhiteTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ))
                  ]),
            );
          },
        ));
  }
}

class EditWidget extends StatelessWidget {
  final String title;
  final Function onTapEdit;

  const EditWidget({
    super.key,
    required this.title,
    required this.onTapEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              onTapEdit();
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: Get.width - 20,
              decoration: BoxDecoration(
                  color: ColorRes.themeColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                title,
                style: kLightTextStyle.copyWith(color: Colors.white),
              ),
            ),
          ),
          // InkWell(
          //   onTap: () {},
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Align(
          //       alignment: Alignment.bottomRight,
          //       child: BgRoundImageWidget(
          //         image: AssetRes.icEdit,
          //         onTap: () {
          //           onTapEdit();
          //         },
          //         height: 30,
          //         width: 30,
          //         imagePadding: 5,
          //         bgColor: ColorRes.charcoal50,
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
