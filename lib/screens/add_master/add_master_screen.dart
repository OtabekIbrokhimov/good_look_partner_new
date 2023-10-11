import 'dart:io';

import 'package:cutfx_salon/bloc/edit/edit_profile_bloc.dart';
import 'package:cutfx_salon/bloc/manageservices/manage_service_bloc.dart';
import 'package:cutfx_salon/screens/main/main_screen.dart';
import 'package:cutfx_salon/screens/manageServices/item_manage_service.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../addService/add_service_screen.dart';
import '../manageServices/tab_bar_of_manage_service.dart';

class AddMasterScreen extends StatelessWidget {
  const AddMasterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EditProfileBloc(),
        child: Scaffold(
            body:SingleChildScrollView(child:  Column(children: [

              BlocBuilder<EditProfileBloc, EditProfileState>(
                builder: (context, state) {
                  EditProfileBloc editProfileBloc = context.read<EditProfileBloc>();
                  return Container(
                      height: 340,
                      child:Column(
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

                          Expanded(
                            child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWithTextFieldSmokeWhiteWidget(
                                      title: "Full name",
                                      controller:
                                      editProfileBloc.fullNameTextController,
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ));
                },
              ),
              SizedBox(
                  height: 300,
                  width: Get.width,
                  child:   BlocProvider(
                    create: (context) => ManageServiceBloc(),
                    child: Scaffold(
                      body: Column(
                        children: [
                          const TabBarOfManageServiceWidget(),
                          Expanded(
                            child: BlocBuilder<ManageServiceBloc, ManageServiceState>(
                              builder: (context, state) {
                                if (state is LoadingServiceState) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: ColorRes.themeColor,
                                    ),
                                  );
                                }
                                if (state is ServiceDataFoundState) {
                                  return ListView.builder(
                                    itemCount: state.services?.length ?? 0,
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    itemBuilder: (context, index) => ItemManageService(
                                      serviceData: state.services?[index],
                                      isShowFromManage: true,
                                      needEdit: false,
                                    ),
                                  );
                                }
                                return const DataNotFound();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,),
                  child: SafeArea(
                    top: false,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff62B654),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width:150,
                      height: 50,
                      child: TextButton(
                        style: const ButtonStyle(
                        ),
                        onPressed: () {
                        },
                        child: const Text(
                          'Free time',
                          style: kRegularWhiteTextStyle,
                        ),
                      ),
                    ),
                  ),
                ), Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,),
                  child: SafeArea(
                    top: false,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffFF6C6C),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width:150,
                      height: 50,
                      child: TextButton(

                        onPressed: () {
                        },
                        child: Text(
                          'Work time',
                          style: kRegularWhiteTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),],),

              BlocBuilder<EditProfileBloc, EditProfileState>(
                  builder: (context, state) {
                    EditProfileBloc editProfileBloc = context.read<EditProfileBloc>();
                    return  Padding(
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
                              editProfileBloc.add(SubmitEditProfileEvent());
                            },
                            child: Text(
                              AppLocalizations.of(context)!.submit,
                              style: kRegularWhiteTextStyle,
                            ),
                          ),
                        ),
                      ),
                    );}),

            ]))),);
  }
}
