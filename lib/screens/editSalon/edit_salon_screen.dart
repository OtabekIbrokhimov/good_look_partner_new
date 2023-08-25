import 'dart:io';

import 'package:cutfx_salon/bloc/editsalon/edit_salon_detail_screen_bloc.dart';
import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'edit_salon_categories_widget.dart';

class EditSalonDetailsScreen extends StatelessWidget {
  const EditSalonDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditSalonDetailBloc(),
      child: Scaffold(
        body: BlocBuilder<EditSalonDetailBloc, EditSalonDetailState>(
          builder: (context, state) {
            EditSalonDetailBloc editSalonDetailBloc =
                context.read<EditSalonDetailBloc>();
            return Column(
              children: [
                ToolBarWidget(
                  title: AppLocalizations.of(context)!.editSalonDetails,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWithTextFieldSmokeWhiteWidget(
                          title: AppLocalizations.of(context)!.salonName,
                          controller: editSalonDetailBloc.salonNameController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.aboutSalon,
                          style: kLightWhiteTextStyle.copyWith(
                            color: ColorRes.black,
                            fontSize: 16,
                          ),
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
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                            ),
                            style: kRegularTextStyle.copyWith(
                              fontSize: 15,
                              color: ColorRes.charcoal50,
                            ),
                            maxLines: 7,
                            maxLength: 450,
                            controller:
                                editSalonDetailBloc.aboutSalonController,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            '${editSalonDetailBloc.aboutSalonController.text.length}/450',
                            style: kThinWhiteTextStyle.copyWith(
                              color: ColorRes.mortar,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextWithTextFieldSmokeWhiteWidget(
                          title: AppLocalizations.of(context)!.salonAddress,
                          controller:
                              editSalonDetailBloc.salonAddressController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: ColorRes.smokeWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                width: Get.width / 4,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: ColorRes.nero,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                              ),
                              InternationalPhoneNumberInput(
                                textFieldController:
                                    editSalonDetailBloc.salonPhoneController,
                                onInputChanged: (PhoneNumber number) {
                                  editSalonDetailBloc.salonPhone =
                                      '${number.dialCode} ${number.parseNumber()}';
                                },
                                countrySelectorScrollControlled: true,
                                selectorConfig: const SelectorConfig(
                                  selectorType: PhoneInputSelectorType.DIALOG,
                                  leadingPadding: 7,
                                  trailingSpace: true,
                                  showFlags: true,
                                  useEmoji: true,
                                ),
                                selectorTextStyle:
                                    kRegularEmpressTextStyle.copyWith(
                                  color: ColorRes.white,
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                textStyle: kRegularEmpressTextStyle.copyWith(
                                  color: ColorRes.charcoal50,
                                ),
                                cursorColor: ColorRes.themeColor,
                                keyboardAction: TextInputAction.done,
                                initialValue: PhoneNumber(
                                  dialCode: editSalonDetailBloc.dailCode,
                                  isoCode: PhoneNumber.getISO2CodeByPrefix(
                                      editSalonDetailBloc.dailCode),
                                ),
                                formatInput: true,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: false),
                                inputDecoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(left: 5),
                                  isCollapsed: false,
                                  counterText: "",
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.salonLocation,
                          style: kLightWhiteTextStyle.copyWith(
                            color: ColorRes.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: TextButton(
                            style: kButtonThemeStyle.copyWith(
                              backgroundColor: MaterialStateProperty.all(
                                editSalonDetailBloc.latLng != null
                                    ? ColorRes.green10
                                    : ColorRes.smokeWhite,
                              ),
                            ),
                            onPressed: () {
                              editSalonDetailBloc.onTapFetchLocation();
                            },
                            child: Text(
                              editSalonDetailBloc.latLng != null
                                  ? AppLocalizations.of(context)!
                                      .locationFetched
                                  : AppLocalizations.of(context)!
                                      .clickToFetchLocation,
                              style: kRegularWhiteTextStyle.copyWith(
                                color: editSalonDetailBloc.latLng != null
                                    ? ColorRes.green
                                    : ColorRes.empress,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const EditSalonCategoriesWidget(
                          horizontalPadding: 0,
                          verticalPadding: 20,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.salonImages,
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
                              Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      editSalonDetailBloc.imageList?.length ??
                                          0,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    Images? image =
                                        editSalonDetailBloc.imageList?[index];
                                    return Container(
                                      margin: const EdgeInsets.only(right: 6),
                                      height: 60,
                                      width: 60,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: image?.id == -123
                                                ? Image(
                                                    image: FileImage(
                                                      File('${image?.image}'),
                                                    ),
                                                    height: 60,
                                                    width: 60,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        errorBuilderForImage,
                                                    loadingBuilder:
                                                        loadingImage,
                                                  )
                                                : Image(
                                                    image: NetworkImage(
                                                      '${ConstRes.itemBaseUrl}${editSalonDetailBloc.imageList?[index].image}',
                                                    ),
                                                    height: 60,
                                                    width: 60,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        errorBuilderForImage,
                                                    loadingBuilder:
                                                        loadingImage,
                                                  ),
                                          ),
                                          CustomCircularInkWell(
                                            onTap: () {
                                              editSalonDetailBloc
                                                  .onTapRemoveImage(index);
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.white38,
                                              ),
                                              padding: const EdgeInsets.all(5),
                                              child: const Image(
                                                image: AssetImage(
                                                    AssetRes.icRemove),
                                                height: 30,
                                                width: 30,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              CustomCircularInkWell(
                                onTap: () {
                                  editSalonDetailBloc.onAddImageClick();
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: ColorRes.smokeWhite,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    margin: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                      bottom: 15,
                      top: 10,
                    ),
                    child: TextButton(
                      onPressed: () {
                        editSalonDetailBloc.onTapSubmit();
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
