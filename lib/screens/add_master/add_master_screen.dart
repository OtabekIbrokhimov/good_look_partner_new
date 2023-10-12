import 'dart:io';

import 'package:cutfx_salon/bloc/edit/edit_profile_bloc.dart';
import 'package:cutfx_salon/screens/add_master/add_time_screen.dart';
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

class AddMasterScreen extends StatelessWidget {
  const AddMasterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EditProfileBloc(),
        child: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            EditProfileBloc editProfileBloc = context.read<EditProfileBloc>();
            editProfileBloc.takeAllInformation();
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
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      "Create master",
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
                                    margin: const EdgeInsets.symmetric(horizontal: 15),
                                    child: ClipRRect(
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(20)),
                                      child: Stack(
                                        children: [
                                          editProfileBloc.imageFile != null
                                              ? Image(
                                            height: double.infinity,
                                            width: double.infinity,
                                            image: FileImage(
                                              editProfileBloc.imageFile ??
                                                  File('path'),
                                            ),
                                            fit: BoxFit.cover,
                                            loadingBuilder: loadingImage,
                                            errorBuilder: errorBuilderForImage,
                                          )
                                              : Image(
                                            height: double.infinity,
                                            width: double.infinity,
                                            image: NetworkImage(
                                                '${ConstRes.itemBaseUrl}${editProfileBloc.imageUrl}'),
                                            fit: BoxFit.cover,
                                            loadingBuilder: loadingImage,
                                            errorBuilder: errorBuilderForImage,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: BgRoundImageWidget(
                                                image: AssetRes.icEdit,
                                                onTap: () {
                                                  editProfileBloc
                                                      .add(ImageSelectClickEvent());
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWithTextFieldSmokeWhiteWidget(
                                      title: "Full name",
                                      controller: editProfileBloc
                                          .fullNameTextController,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            EditWidget(
                              title: "Edit service",
                              onTapEdit: () async {
                                List<int> items = await Get.to(
                                    () => const ChooseServiceScreen(),
                                    arguments: editProfileBloc.ids);
                                Get.log(items.toString());
                                editProfileBloc.takeIds(items);
                              },
                            ),
                            EditWidget(
                              title: "Edit time",
                              onTapEdit: () {
                                Get.to(const AddTimeScreen());
                              },
                            ),
                            SizedBox(height: Get.width / 2),
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
                                      editProfileBloc.createMaster();
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.submit,
                                      style: kRegularWhiteTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            title,
            style: kBoldThemeTextStyle,
          ),
        ),
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: BgRoundImageWidget(
                image: AssetRes.icEdit,
                onTap: () {
                  onTapEdit();
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
    );
  }
}
