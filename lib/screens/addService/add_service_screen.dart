import 'dart:io';

import 'package:cutfx_salon/bloc/addservice/add_service_bloc.dart';
import 'package:cutfx_salon/model/cat/categories.dart';
import 'package:cutfx_salon/model/service/services.dart';
import 'package:cutfx_salon/screens/registration/signup_salon_categories_widget.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddServiceScreen extends StatelessWidget {
  const AddServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddServiceBloc(),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToolBarWidget(
              title: AppLocalizations.of(context)!.addService,
            ),
            Expanded(
              child: BlocBuilder<AddServiceBloc, AddServiceState>(
                builder: (context, state) {
                  AddServiceBloc addServiceBloc =
                      context.read<AddServiceBloc>();
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.selectCategory,
                          style: kLightWhiteTextStyle.copyWith(
                            color: ColorRes.black,
                            fontSize: 16,
                          ),
                        ),
                        const SelectCategoryWidget(),
                        const SizedBox(
                          height: 10,
                        ),
                        TextWithTextFieldSmokeWhiteWidget(
                          title: AppLocalizations.of(context)!.serviceTitle,
                          controller: addServiceBloc.serviceTitleController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.price,
                                    style: kLightWhiteTextStyle.copyWith(
                                      color: ColorRes.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ColorRes.smokeWhite,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 55,
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: ColorRes.smokeWhite1,
                                            borderRadius:
                                                BorderRadius.horizontal(
                                              left: Radius.circular(10),
                                            ),
                                          ),
                                          height: double.infinity,
                                          width: 60,
                                          child: Center(
                                            child: Text(
                                              AppRes.currency,
                                              style:
                                                  kSemiBoldTextStyle.copyWith(
                                                color: ColorRes.themeColor,
                                                fontSize: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: TextField(
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                              controller: addServiceBloc
                                                  .priceController,
                                              style: kRegularTextStyle.copyWith(
                                                color: ColorRes.charcoal50,
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .discountOptional,
                                    style: kLightWhiteTextStyle.copyWith(
                                      color: ColorRes.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ColorRes.smokeWhite,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 55,
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: ColorRes.smokeWhite1,
                                            borderRadius:
                                                BorderRadius.horizontal(
                                              left: Radius.circular(10),
                                            ),
                                          ),
                                          height: double.infinity,
                                          width: 60,
                                          child: Center(
                                            child: Text(
                                              '%',
                                              style:
                                                  kSemiBoldTextStyle.copyWith(
                                                color: ColorRes.themeColor,
                                                fontSize: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: TextField(
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                              controller: addServiceBloc
                                                  .discountController,
                                              style: kRegularTextStyle.copyWith(
                                                color: ColorRes.charcoal50,
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            timePicking2(context, addServiceBloc.takeMinute);
                          },
                          child: TextWithTextFieldSmokeWhiteWidget(
                            enable: false,
                            title: AppLocalizations.of(context)!.timeItTakesMin,
                            controller: addServiceBloc.timeItTakesController,
                            textInputType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.genderServiceIsFor,
                          style: kLightWhiteTextStyle.copyWith(
                            color: ColorRes.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AddServiceGenderWidget(
                          horizontalPadding: 0,
                          signUpBloc: addServiceBloc,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.aboutService,
                          style: kLightWhiteTextStyle.copyWith(
                            color: ColorRes.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: ColorRes.smokeWhite,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: ColorRes.smokeWhite,
                              width: 0.5,
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            style: kRegularTextStyle.copyWith(
                              color: ColorRes.charcoal50,
                            ),
                            controller: addServiceBloc.aboutServiceController,
                            maxLines: 7,
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            '${addServiceBloc.aboutServiceController.text.length}/400',
                            style: kThinWhiteTextStyle.copyWith(
                              color: ColorRes.mortar,
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.serviceImages,
                          style: kLightWhiteTextStyle.copyWith(
                            color: ColorRes.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 60,
                          child: Row(
                            children: [
                              CustomCircularInkWell(
                                onTap: () {
                                  addServiceBloc.onAddImageClick();
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: ColorRes.smokeWhite,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: const EdgeInsets.only(right: 10),
                                  child: const Center(
                                    child: Image(
                                      image: AssetImage(AssetRes.icPlus_),
                                      color: ColorRes.darkGray,
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      addServiceBloc.imageList?.length ?? 0,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    Images? image =
                                        addServiceBloc.imageList?[index];
                                    return Container(
                                      margin: const EdgeInsets.only(right: 6),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                image?.id == -123
                                                    ? Image(
                                                        image: FileImage(
                                                          File(
                                                              '${image?.image}'),
                                                        ),
                                                        height: 60,
                                                        width: 60,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image(
                                                        image: NetworkImage(
                                                          '${ConstRes.itemBaseUrl}${addServiceBloc.imageList?[index].image}',
                                                        ),
                                                        height: 60,
                                                        width: 60,
                                                        fit: BoxFit.cover,
                                                        loadingBuilder:
                                                            loadingImage,
                                                        errorBuilder:
                                                            errorBuilderForImage,
                                                      ),
                                                CustomCircularInkWell(
                                                  onTap: () {
                                                    addServiceBloc
                                                        .onTapRemoveImage(
                                                            index);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: ColorRes.white
                                                          .withOpacity(.3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    height: 30,
                                                    width: 30,
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: const Image(
                                                      image: AssetImage(
                                                        AssetRes.icBin,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
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
                    ),
                  );
                },
              ),
            ),
            Builder(builder: (context) {
              AddServiceBloc addServiceBloc = context.read<AddServiceBloc>();
              return SafeArea(
                top: false,
                child: Container(
                  width: double.infinity,
                  height: 55,
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 15,
                    top: 10,
                  ),
                  child: TextButton(
                    onPressed: () {
                      addServiceBloc.onTapSubmit();
                    },
                    style: kButtonThemeStyle,
                    child: Text(
                      AppLocalizations.of(context)!.submit,
                      style: kBlackButtonTextStyle.copyWith(
                        color: ColorRes.white,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class SelectCategoryWidget extends StatefulWidget {
  const SelectCategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectCategoryWidget> createState() => _SelectCategoryWidgetState();
}

class _SelectCategoryWidgetState extends State<SelectCategoryWidget> {
  List<CategoryData> categories = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddServiceBloc, AddServiceState>(
      builder: (context, state) {
        AddServiceBloc addServiceBloc = context.read<AddServiceBloc>();
        categories = addServiceBloc.categories?.data ?? [];
        return SizedBox(
          height: 125,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: categories.length,
            primary: false,
            padding: const EdgeInsets.symmetric(vertical: 5),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              CategoryData categoryData = categories[index];
              return AspectRatio(
                aspectRatio: 1 / 1.1,
                child: CustomCircularInkWell(
                  onTap: () {
                    addServiceBloc.selectedCatId = categoryData.id ?? 0;
                    setState(() {});
                    context
                        .read<AddServiceBloc>()
                        .selectCatId(categoryData.id ?? -1);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: addServiceBloc.selectedCatId == categoryData.id
                            ? ColorRes.lavender50
                            : ColorRes.catigoriesColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            image: NetworkImage(
                                '${ConstRes.itemBaseUrl}${categoryData.icon}'),
                            fit: BoxFit.cover)),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        // Expanded(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(10),
                        //     child: AspectRatio(
                        //       aspectRatio: 1 / 1,
                        //       child: Image(
                        //         image: NetworkImage(
                        //             '${ConstRes.itemBaseUrl}${categoryData.icon}'),
                        //
                        //         errorBuilder: (context, error, stackTrace) {
                        //           return const ImageNotFound(
                        //             color: ColorRes.transparent,
                        //           );
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            '${categoryData.title}',
                            style: kRegularTextStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

void timePicking2(BuildContext context, Function(String text) findHowLong) {
  Get.bottomSheet(
      Container(
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
                      child: const Icon(
                        Icons.close,
                        color: ColorRes.black,
                        size: 35,
                      )),
                ],
              ),
              TimePickerSpinner(
                time: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day, 0),
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
                  int minutes = ((time.hour * 60) + time.minute);
                  findHowLong(minutes.toString());
                },
              ),
            ],
          )),
      enableDrag: false);
}

class AddServiceGenderWidget extends StatefulWidget {
  final double? horizontalPadding;
  final double? verticalPadding;
  final AddServiceBloc? signUpBloc;

  const AddServiceGenderWidget({
    Key? key,
    this.horizontalPadding,
    this.verticalPadding,
    this.signUpBloc,
  }) : super(key: key);

  @override
  State<AddServiceGenderWidget> createState() => _AddServiceGenderWidgetState();
}

class _AddServiceGenderWidgetState extends State<AddServiceGenderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding ?? 15),
      child: Row(
        children: [
          Expanded(
            child: ItemGenderWidget(
              title: AppLocalizations.of(context)!.male,
              filterIsSelected: widget.signUpBloc?.gender == 0,
              onTap: () {
                widget.signUpBloc?.gender = 0;
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: ItemGenderWidget(
              title: AppLocalizations.of(context)!.female,
              filterIsSelected: widget.signUpBloc?.gender == 1,
              onTap: () {
                widget.signUpBloc?.gender = 1;
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: ItemGenderWidget(
              title: AppLocalizations.of(context)!.unisex,
              filterIsSelected: widget.signUpBloc?.gender == 2,
              onTap: () {
                widget.signUpBloc?.gender = 2;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
