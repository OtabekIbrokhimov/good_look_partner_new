import 'package:cutfx_salon/bloc/manageservices/manage_service_bloc.dart';
import 'package:cutfx_salon/model/service/services.dart';
import 'package:cutfx_salon/screens/addService/add_service_screen.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/ext/num_ext.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ItemManageService extends StatelessWidget {
  final ServiceData? serviceData;
  final bool isShowFromManage;
  final bool needEdit;
  final Function(int id) whenSelected;
  final List<int> list;

  const ItemManageService(
      {Key? key,
      required this.serviceData,
      required this.isShowFromManage,
      this.needEdit = true,
      required this.whenSelected,
      this.list = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / .35,
      child: GestureDetector(
        onTap: () {
          whenSelected(serviceData?.id ?? 0);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: checkIt(list, serviceData?.id ?? 0)
                ? ColorRes.darkGray
                : ColorRes.smokeWhite,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Image(
                          image: NetworkImage(
                              '${ConstRes.itemBaseUrl}${serviceData?.images != null && serviceData!.images!.isNotEmpty ? serviceData!.images![0].image : ''}'),
                          fit: BoxFit.cover,
                          loadingBuilder: loadingImage,
                          errorBuilder: errorBuilderForImage,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Visibility(
                          visible: isShowFromManage && needEdit,
                          child: CustomCircularInkWell(
                            onTap: () {
                              context
                                  .read<ManageServiceBloc>()
                                  .deleteService(serviceData);
                            },
                            child: Container(
                              height: 36,
                              width: 36,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white38,
                              ),
                              padding: const EdgeInsets.all(5),
                              child: const Image(
                                image: AssetImage(AssetRes.icRemove),
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      bottom: 2,
                      right: 10,
                      left: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${serviceData?.title}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kSemiBoldTextStyle.copyWith(
                            color: ColorRes.nero,
                            fontSize: 15,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      (serviceData?.price ?? 0).currency,
                                      style: kBoldThemeTextStyle.copyWith(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        '-',
                                        style: kThinWhiteTextStyle.copyWith(
                                          color: ColorRes.mortar,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${serviceData?.serviceTime} Min',
                                      style: kThinWhiteTextStyle.copyWith(
                                        color: ColorRes.mortar,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  AppRes.getGenderTypeInStringFromNumber(
                                          context, serviceData?.gender ?? 0)
                                      .toUpperCase(),
                                  style: kLightWhiteTextStyle.copyWith(
                                    color: ColorRes.empress,
                                    letterSpacing: 2,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Visibility(
                                visible: isShowFromManage && needEdit,
                                child: Row(
                                  children: [
                                    CustomCircularInkWell(
                                      onTap: () {
                                        Get.to(
                                          () => const AddServiceScreen(),
                                          arguments: serviceData,
                                        )?.then((value) {
                                          context
                                              .read<ManageServiceBloc>()
                                              .onTapCategory(
                                                  serviceData?.categoryId ??
                                                      -1);
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: ColorRes.smokeWhite,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        margin: const EdgeInsets.only(
                                            right: 10, bottom: 4),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        child: Text(
                                          AppLocalizations.of(context)!.edit,
                                          style: kRegularTextStyle.copyWith(
                                            color: ColorRes.themeColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ToggleButton(
                                      isActive: serviceData?.status == 1,
                                      onToggleChange: (isActive) {
                                        ApiService().changeServiceStatus(
                                          serviceId:
                                              serviceData?.id.toString() ??
                                                  '-1',
                                          status: isActive ? '1' : '0',
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void timePicking2(BuildContext context,) {
  //   Get.bottomSheet(Container(
  //       padding: const EdgeInsets.all(15),
  //       height: Get.height / 2,
  //       color: Colors.white,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: [
  //
  //               InkWell(
  //                   onTap: () {
  //                     Get.back();
  //                   },
  //                   child: const Icon(Icons.close,color: ColorRes.black,size: 35,)
  //               ),
  //
  //             ],
  //           ),
  //           TimePickerSpinner(
  //             minutesInterval: 15,
  //             is24HourMode: true,
  //             normalTextStyle:
  //             const TextStyle(fontSize: 24, color: Colors.grey),
  //             highlightedTextStyle:
  //             const TextStyle(fontSize: 24, color: ColorRes.themeColor),
  //             spacing: 50,
  //             itemHeight: 80,
  //             isForce2Digits: true,
  //             onTimeChange: (time) {
  //               ok.selectTime(time, isStart);
  //             },
  //           ),
  //
  //         ],
  //       )));
  // }
  bool checkIt(List<int> list, int id) {
    if (list.isEmpty) {
      return false;
    }
    for (int i = 0; i < list.length; i++) {
      if (id == list[i]) {
        return true;
      }
    }
    return false;
  }
}
