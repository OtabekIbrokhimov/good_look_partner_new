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

  const ItemManageService(
      {Key? key, required this.serviceData, required this.isShowFromManage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / .35,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          color: ColorRes.smokeWhite2,
          borderRadius: BorderRadius.all(Radius.circular(15)),
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
                        visible: isShowFromManage,
                        child: CustomCircularInkWell(
                          onTap: () {
                            context
                                .read<ManageServiceBloc>()
                                .deleteService(serviceData);
                          },
                          child: Container(
                            height: 35,
                            width: 35,
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
                    bottom: 5,
                    right: 10,
                    left: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${serviceData?.title}',
                        style: kSemiBoldTextStyle.copyWith(
                          color: ColorRes.nero,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
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
                                      fontSize: 17,
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
                          Visibility(
                            visible: isShowFromManage,
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
                                              serviceData?.categoryId ?? -1);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: ColorRes.smokeWhite,
                                      borderRadius: BorderRadius.circular(100),
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
                                          serviceData?.id.toString() ?? '-1',
                                      status: isActive ? '1' : '0',
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
